# Qvik's Swift utility collection

*This library contains Swift 5 utilities for use in both Qvik's internal and customer projects.*

## Usage

To use the library in your projects, add the following (or what ever suits your needs) to your Podfile:

```ruby
source 'https://github.com/qvik/qvik-podspecs.git'

pod 'QvikSwift', '~> 6.0'
```

And the following to your source:

```ruby
import QvikSwift
```

## Versions

Use the following library versions for the corresponding Swift language versions:

* 6.x - Swift 5
* 5.x - Swift 4.2

## Changelog

* 6.0.1 
  * Added Bundle.displayName
* 6.0.0
  * Swift 5 compatibility
* 5.0.0
  * Some API breaking changes; swiftlint warning fixes; swift 4.2 compliance
* 4.0.5
   * Bug fix to UIGestureRecognizerExtensions
* 4.0.4 
   * Added NSLayoutConstrait.match()
* 4.0.0
    * Converted to Swift 4 / Xcode 9 recommended settings
* 3.0.2
    * Added storing / extracting Float/Double values into a Data
* 3.0.1
    * Fixed a Xcode 8.3 / Swift 3.1 deprecation warnings
* 3.0.0
    * Converted to Swift3
* 2.0.19 
    * Added various utils
* 2.0.18 
    * Added UIGestureRecognizerExtensions
* 2.0.16
    * Added ParallaxView
    * Added subscript operators to StringExtensions
* 2.0.15
    * Moved Podspec to point to Github
* 2.0.14
    * Added UIResponderExtensions: getCurrentFirstResponder() / resignCurrentFirstResponder()
* 2.0.13
    * Bugfix to runOnMainThreadAfter()
* 2.0.12
    * Small bugfix release. Renamed UIImage.scale() -> UIImage.scaleTo() to avoid ambiguity.
* 2.0.11 
    * Added image scaling methods. 
    * Made ReadWriteLock:s closure methods @noescape
* 2.0.10 
    * Added random() convenience methods to number types
    * Added CGSize.aspectSizeToFit() 
* 2.0.9
    * Deprecated UIView.screenshot() and introduced .snapshot() - with support for opaque / scale params.
* 2.0.7
    * Added NSBundle extensions for retrieving app / build version strings
    * Added String.trim()
* 2.0.6 
    * Improved UIColor(hexString:) input format support
* 2.0.5
    * Added QvikImageView; added String.urlEncoded
* 2.0.4
    * Removed the UIButtonExtensions that was causing problems
    * Renamed BlockButton -> QvikButton and added the UIButtonExtensions stuff to it
* 2.0.2 
	* Added a high-level API for ReadWriteLock
* 2.0.1
	* Added ExpandingTextView
* 2.0.0
	* Swift2 / iOS9 support
	* Added more convenience extensions for UIView / CGRect
	* Added BlockButton

## Features

This library mostly provides more or less handy extensions to the platform classes such as UIView, UIImage, CGRect, String, Array, NSDateFormatter, CGPoint, UIColor etc. Browse the source inside the Pod package for full inventory. 

Most notable features are:


* **ReadWriteLock**
A synchronization lock for interthread resource access. The implementation is based on **pthread_rwlock_t**.
The recommended way to use the lock is via the higher level methods:
```swift
let value: Int = lock.withReadLock {
	return myDataStructure.findValue(key)
}
// .. 
lock.withWriteLock {
	myDataStructure.insertValue(newValue, key: key)
}
```
Or you can use the lower level API for finer-grained control:
```swift
func foo() {}
	defer {
		lock.unlock()
	}
	lock.lockToWrite()
	// Write safely to a shared resource
}
func bar() {
	defer {
	    lock.unlock()
    }
    lock.lockToRead()
    // Read safely from a shared resource
}
```

* **Threading utils**
The library provides global functions for asynchronously executing a block of code on main or an background thread.
```swift
runInBackground {
	// Execute a long running task on an unspecified background thread
    runOnMainThread {
    	// After the task completes, notify the UI thread about the completion
    }
}
```

* **UIImage utils**
The library provides certain commonly used image manipulation utilities.
```swift
let blurredImage = image.blur(5.0) // Returns a blurred image
let croppedImage = image.cropImageToSquare() // Returns a cropped square image from the middle of the original
let normalizedImage = image.imageWithNormalizedOrientation() // Returns an image with any orientation information removed
let scaledImage = image.scaleDown(maxSize: CGSize(width: 800, height: 800)) // Returns an image with max size 800x800, scaled down if required, with original aspect ratio
```

## Contributing 

Contributions to this library are welcomed. Any contributions have to meet the following criteria:

* Meaningfulness. Discuss whether what you are about to contribute indeed belongs to this library in the first place before submitting a pull request.
* Code style. Follow our [Swift style guide](https://github.com/qvik/swift) 100%.
* Stability. No code in the library must ever crash; never place *assert()*s or implicit optional unwrapping in library methods.
* Testing. Every util method, function and extension in the library must have unit tests, preferably triggering both successful and unsuccessful calls. All custom views/controls should have proper documentation and usage examples.
* Logging. No production code in the library must write logs. Unit tests may output logs.

### License

The library is distributed with the MIT License. Make sure all your source files contain the license header at the start of the file:

```
// The MIT License (MIT)
//
// Copyright (c) 2015-2018 Qvik (www.qvik.fi)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
```

### Submit your code

All merges to the **master** branch go through a *Merge ('pull') Request* and MUST meet the above criteria.

In other words, follow the following procedure to submit your code into the library:

* Clone the library repository
* Create a feature branch for your code
* Code it, clean it up, test it thoroughly
* Make sure all your methods meant to be public are defined as public
* Push your branch
* Create a merge request

## Updating the pod

As a contributor you do not need to do this; we'll update the pod whenever needed by projects.

* Update QvikSwift.podspec and set s.version to match the upcoming tag
* Commit all your changes, merge all pending accepted *Merge ('pull') Requests*
* Create a new tag following [Semantic Versioning](http://semver.org/); eg. `git tag -a 6.0.9 -m "Your tag comment"`
* `git push --tags`
* `pod repo push qvik-podspecs QvikSwift.podspec`

Unless already set up, you might do the following steps to set up the pod repo:

* ```pod repo add qvik-podspecs https://github.com/qvik/qvik-podspecs.git```

## Contact

Any questions? Contact matti@qvik.fi.
