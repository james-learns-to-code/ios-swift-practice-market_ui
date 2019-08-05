# ios-swift-test-market

Market application for iOS

## Purpose

Demonstrate building app for online market service.

## Echo server

For implement echo server, i made echo-server application using python(https://github.com/james-learns-to-code/python-http-echo-server).  
For establishing echo server, i need a server instance.  
I already has a AWS lightsail instance for running web server, but i don't wanna use it.  
So i decide to using raspberry pi for running web server.  

## Routing

I want to use my own domain 'http://goodeffect.com' for requesting api.  
So i create A record named 'api' and direct to raspberry pi's IP address.  
Because of my raspberry pi is connected WIFI, i have to port forwarding for routing request to raspberry pi.   
Therefore, api url is started with 'http://api.goodeffect.com:11000/  

## Peek side of CollectionView

For implementing peek previous/forward page with pagination UICollectionView, have to use scrollView delegate.

```
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollBeginOffset = scrollView.contentOffset
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = itemSize.width + SelfClass.lineSpace
        // Scroll if user scrolling only 10% of page width
        let snapTolerance: CGFloat = 0.1
        let snapDelta: CGFloat = (scrollView.contentOffset.x > scrollBeginOffset.x) ?
            1 - snapTolerance : snapTolerance
        let widthForSnapping = pageWidth * snapDelta
        let snappedOffest = scrollView.contentOffset.x + widthForSnapping
        let pageIndex = floor(snappedOffest / pageWidth)
        let pageOffset = pageWidth * pageIndex
        targetContentOffset.pointee = CGPoint(x: pageOffset, y: targetContentOffset.pointee.y)
    }
```

When drag is begin, store current offset.  
When drag is ended, calculate paginated offset and change targetContentOffset.pointee which is inout value.  
For supporting snapping, add snap size when calculating page offset.

## Nested CollectionView

For supporting pagination UICollectionView nested in UITableViewCell, have to use scrollView delegate. 

```
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndexPath = getCurrentIndexPathFrom(collectionView)
        delegate?.didScroll(self, to: currentIndexPath.row)
    }
    private func getCurrentIndexPathFrom(_ collectionView: UICollectionView) -> IndexPath {
        let newPage = Int(floor(collectionView.contentOffset.x / max(1, collectionView.frame.width)))
        return IndexPath(row: newPage, section: 0)
    }
```

When user finish paging in collectionView, store new indexPath and notice to main VC.


```
    self.tableView.beginUpdates()
    self.tableView.endUpdates()
```

In VC, have to update tableView for updating cell height.

```
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
```

For setting exact size of paging, return collectionView frame size.

```
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
```

When tableViewCell that has collectionView is updating, have to invalidate layout.
