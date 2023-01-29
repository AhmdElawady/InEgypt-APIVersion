//
//  ImageScrollView.swift
//  InEgypt
//
//  Created by Awady on 12/29/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

public class ImageScrollView: UIScrollView, UIGestureRecognizerDelegate {
    
    // MARK: - Public
    
    public var imageView: UIImageView? {
        didSet {
            oldValue?.removeGestureRecognizer(self.tap)
            oldValue?.removeFromSuperview()
            if let imageView = self.imageView {
                self.initialImageFrame = .null
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(self.tap)
                self.addSubview(imageView)
            }
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    deinit {
        self.stopObservingBoundsChange()
    }
    
    // MARK: - UIScrollView
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setupInitialImageFrame()
    }
    
    public override var contentOffset: CGPoint {
        didSet {
            let contentSize = self.contentSize
            let scrollViewSize = self.bounds.size
            var newContentOffset = contentOffset
            
            if contentSize.width < scrollViewSize.width {
                newContentOffset.x = (contentSize.width - scrollViewSize.width) * 0.5
            }
            
            if contentSize.height < scrollViewSize.height {
                newContentOffset.y = (contentSize.height - scrollViewSize.height) * 0.5
            }
            
            super.contentOffset = newContentOffset
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer === self.panGestureRecognizer
    }
    
    // MARK: - Private: Tap to Zoom
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToZoom(_:)))
        tap.numberOfTapsRequired = 2
        tap.delegate = self
        return tap
    }()
    
    @objc private func tapToZoom(_ sender: UIGestureRecognizer) {
        guard sender.state == .ended else { return }
        
        if self.zoomScale > self.minimumZoomScale {
            self.setZoomScale(self.minimumZoomScale, animated: true)
        } else {
            guard let imageView = self.imageView else { return }
            
            let tapLocation = sender.location(in: imageView)
            let zoomRectWidth = imageView.frame.size.width / self.maximumZoomScale;
            let zoomRectHeight = imageView.frame.size.height / self.maximumZoomScale;
            let zoomRectX = tapLocation.x - zoomRectWidth * 0.5;
            let zoomRectY = tapLocation.y - zoomRectHeight * 0.5;
            let zoomRect = CGRect(
                x: zoomRectX,
                y: zoomRectY,
                width: zoomRectWidth,
                height: zoomRectHeight)
            self.zoom(to: zoomRect, animated: true)
        }
    }
    
    // MARK: - Private: Geometry
    
    private var initialImageFrame: CGRect = .null
    
    private var imageAspectRatio: CGFloat {
        guard let image = self.imageView?.image else { return 1 }
        return image.size.width / image.size.height
    }
    
    private func configure() {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.startObservingBoundsChange()
    }
    
    private func rectSize(for aspectRatio: CGFloat, thatFits size: CGSize) -> CGSize {
        let containerWidth = size.width
        let containerHeight = size.height
        var resultWidth: CGFloat = 0
        var resultHeight: CGFloat = 0
        
        if aspectRatio <= 0 || containerHeight <= 0 {
            return size
        }
        
        if containerWidth / containerHeight >= aspectRatio {
            resultHeight = containerHeight
            resultWidth = containerHeight * aspectRatio
        } else {
            resultWidth = containerWidth
            resultHeight = containerWidth / aspectRatio
        }
        
        return CGSize(width: resultWidth, height: resultHeight)
    }
    
    private func scaleImageForTransition(from oldBounds: CGRect, to newBounds: CGRect) {
        guard let imageView = self.imageView else { return}
        
        let oldContentOffset = CGPoint(x: oldBounds.origin.x, y: oldBounds.origin.y)
        let oldSize = oldBounds.size
        let newSize = newBounds.size
        var containedImageSizeOld = self.rectSize(for: self.imageAspectRatio, thatFits: oldSize)
        let containedImageSizeNew = self.rectSize(for: self.imageAspectRatio, thatFits: newSize)
        
        if containedImageSizeOld.height <= 0 {
            containedImageSizeOld = containedImageSizeNew
        }
        
        let orientationRatio = containedImageSizeNew.height / containedImageSizeOld.height
        let transform = CGAffineTransform(scaleX: orientationRatio, y: orientationRatio)
        self.imageView?.frame = imageView.frame.applying(transform)
        self.contentSize = imageView.frame.size;
        
        var xOffset = (oldContentOffset.x + oldSize.width * 0.5) * orientationRatio - newSize.width * 0.5
        var yOffset = (oldContentOffset.y + oldSize.height * 0.5) * orientationRatio - newSize.height * 0.5
        
        xOffset -= max(xOffset + newSize.width - self.contentSize.width, 0)
        yOffset -= max(yOffset + newSize.height - self.contentSize.height, 0)
        xOffset -= min(xOffset, 0)
        yOffset -= min(yOffset, 0)
        
        self.contentOffset = CGPoint(x: xOffset, y: yOffset)
    }
    
    private func setupInitialImageFrame() {
        guard self.imageView != nil, self.initialImageFrame == .null else { return }
        let imageViewSize = self.rectSize(for: self.imageAspectRatio, thatFits: self.bounds.size)
        self.initialImageFrame = CGRect(x: 0, y: 0, width: imageViewSize.width, height: imageViewSize.height)
        self.imageView?.frame = self.initialImageFrame
        self.contentSize = self.initialImageFrame.size
    }
    
    // MARK: - Private: KVO
    
    private var boundsObserver: NSKeyValueObservation?
    
    private func startObservingBoundsChange() {
        self.boundsObserver = self.observe(
            \.self.bounds,
             options: [.old, .new],
             changeHandler: { [weak self] (object, change) in
                 if let oldRect = change.oldValue,
                    let newRect = change.newValue,
                    oldRect.size != newRect.size {
                     self?.scaleImageForTransition(from: oldRect, to: newRect)
                 }
             })
    }
    
    private func stopObservingBoundsChange() {
        self.boundsObserver?.invalidate()
        self.boundsObserver = nil
    }
}



//open class ZoomImageView : UIScrollView, UIScrollViewDelegate {
//
//  public enum ZoomMode {
//    case fit
//    case fill
//  }
//
//  // MARK: - Properties
//    public var imageView: UIImageView = {
//    let imageView = UIImageView()
//    imageView.layer.allowsEdgeAntialiasing = true
//    return imageView
//  }()
//
//  public var zoomMode: ZoomMode = .fit {
//    didSet {
//      updateImageView()
//      scrollToCenter()
//    }
//  }
//
//  open var image: UIImage? {
//    get {
//      return imageView.image
//    }
//    set {
//      let oldImage = imageView.image
//      imageView.image = newValue
//
//      if oldImage?.size != newValue?.size {
//        oldSize = nil
//        updateImageView()
//      }
//      scrollToCenter()
//    }
//  }
//
//  open override var intrinsicContentSize: CGSize {
//    return imageView.intrinsicContentSize
//  }
//
//  private var oldSize: CGSize?
//
//  // MARK: - Initializers
//  public override init(frame: CGRect) {
//    super.init(frame: frame)
//    setup()
//  }
//
//  public init(image: UIImage) {
//    super.init(frame: CGRect.zero)
//    self.image = image
//    setup()
//  }
//
//  public required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//    setup()
//  }
//
//  // MARK: - Functions
//  open func scrollToCenter() {
//
//    let centerOffset = CGPoint(
//      x: contentSize.width > bounds.width ? (contentSize.width / 2) - (bounds.width / 2) : 0,
//      y: contentSize.height > bounds.height ? (contentSize.height / 2) - (bounds.height / 2) : 0
//    )
//
//    contentOffset = centerOffset
//  }
//
//  open func setup() {
//
//    #if swift(>=3.2)
//      if #available(iOS 11, *) {
//        contentInsetAdjustmentBehavior = .never
//      }
//    #endif
//
//    backgroundColor = UIColor.clear
//    delegate = self
//    imageView.contentMode = .scaleAspectFill
//    showsVerticalScrollIndicator = false
//    showsHorizontalScrollIndicator = false
//    addSubview(imageView)
//
//    let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
//    doubleTapGesture.numberOfTapsRequired = 2
//    addGestureRecognizer(doubleTapGesture)
//  }
//
//  open override func didMoveToSuperview() {
//    super.didMoveToSuperview()
//  }
//
//  open override func layoutSubviews() {
//
//    super.layoutSubviews()
//
//    if imageView.image != nil && oldSize != bounds.size {
//
//      updateImageView()
//      oldSize = bounds.size
//    }
//
//    if imageView.frame.width <= bounds.width {
//      imageView.center.x = bounds.width * 0.5
//    }
//
//    if imageView.frame.height <= bounds.height {
//      imageView.center.y = bounds.height * 0.5
//    }
//  }
//
//  open override func updateConstraints() {
//    super.updateConstraints()
//    updateImageView()
//  }
//
//  private func updateImageView() {
//
//    func fitSize(aspectRatio: CGSize, boundingSize: CGSize) -> CGSize {
//
//      let widthRatio = (boundingSize.width / aspectRatio.width)
//      let heightRatio = (boundingSize.height / aspectRatio.height)
//
//      var boundingSize = boundingSize
//
//      if widthRatio < heightRatio {
//        boundingSize.height = boundingSize.width / aspectRatio.width * aspectRatio.height
//      }
//      else if (heightRatio < widthRatio) {
//        boundingSize.width = boundingSize.height / aspectRatio.height * aspectRatio.width
//      }
//      return CGSize(width: ceil(boundingSize.width), height: ceil(boundingSize.height))
//    }
//
//    func fillSize(aspectRatio: CGSize, minimumSize: CGSize) -> CGSize {
//      let widthRatio = (minimumSize.width / aspectRatio.width)
//      let heightRatio = (minimumSize.height / aspectRatio.height)
//
//      var minimumSize = minimumSize
//
//      if widthRatio > heightRatio {
//        minimumSize.height = minimumSize.width / aspectRatio.width * aspectRatio.height
//      }
//      else if (heightRatio > widthRatio) {
//        minimumSize.width = minimumSize.height / aspectRatio.height * aspectRatio.width
//      }
//      return CGSize(width: ceil(minimumSize.width), height: ceil(minimumSize.height))
//    }
//
//    guard let image = imageView.image else { return }
//
//    var size: CGSize
//
//    switch zoomMode {
//    case .fit:
//      size = fitSize(aspectRatio: image.size, boundingSize: bounds.size)
//    case .fill:
//      size = fillSize(aspectRatio: image.size, minimumSize: bounds.size)
//    }
//
//    size.height = round(size.height)
//    size.width = round(size.width)
//
//    zoomScale = 1
//    maximumZoomScale = image.size.width / size.width
//    imageView.bounds.size = size
//    contentSize = size
//    imageView.center = ZoomImageView.contentCenter(forBoundingSize: bounds.size, contentSize: contentSize)
//  }
//
//  @objc private func handleDoubleTap(_ gestureRecognizer: UITapGestureRecognizer) {
//    if self.zoomScale == 1 {
//      zoom(
//        to: zoomRectFor(
//          scale: max(4, maximumZoomScale / 3),
//          with: gestureRecognizer.location(in: gestureRecognizer.view)),
//        animated: true
//      )
//    } else {
//      setZoomScale(1, animated: true)
//    }
//  }
//
//  // This function is borrowed from: https://stackoverflow.com/questions/3967971/how-to-zoom-in-out-photo-on-double-tap-in-the-iphone-wwdc-2010-104-photoscroll
//  private func zoomRectFor(scale: CGFloat, with center: CGPoint) -> CGRect {
//    let center = imageView.convert(center, from: self)
//
//    var zoomRect = CGRect()
//    zoomRect.size.height = bounds.height / scale
//    zoomRect.size.width = bounds.width / scale
//    zoomRect.origin.x = center.x - zoomRect.width / 2.0
//    zoomRect.origin.y = center.y - zoomRect.height / 2.0
//
//    return zoomRect
//  }
//
//  // MARK: - UIScrollViewDelegate
//  @objc dynamic public func scrollViewDidZoom(_ scrollView: UIScrollView) {
//    imageView.center = ZoomImageView.contentCenter(forBoundingSize: bounds.size, contentSize: contentSize)
//  }
//
//  @objc dynamic public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
//
//  }
//
//  @objc dynamic public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
//
//  }
//
//  @objc dynamic public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//    return imageView
//  }
//
//  @inline(__always)
//  private static func contentCenter(forBoundingSize boundingSize: CGSize, contentSize: CGSize) -> CGPoint {
//
//    /// When the zoom scale changes i.e. the image is zoomed in or out, the hypothetical center
//    /// of content view changes too. But the default Apple implementation is keeping the last center
//    /// value which doesn't make much sense. If the image ratio is not matching the screen
//    /// ratio, there will be some empty space horizontaly or verticaly. This needs to be calculated
//    /// so that we can get the correct new center value. When these are added, edges of contentView
//    /// are aligned in realtime and always aligned with corners of scrollview.
//    let horizontalOffest = (boundingSize.width > contentSize.width) ? ((boundingSize.width - contentSize.width) * 0.5): 0.0
//    let verticalOffset = (boundingSize.height > contentSize.height) ? ((boundingSize.height - contentSize.height) * 0.5): 0.0
//
//    return CGPoint(x: contentSize.width * 0.5 + horizontalOffest,  y: contentSize.height * 0.5 + verticalOffset)
//  }
//}
