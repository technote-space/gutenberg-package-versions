# Gutenberg Package Versions

[![Build Status](https://travis-ci.com/technote-space/gutenberg-package-versions.svg?branch=master)](https://travis-ci.com/technote-space/gutenberg-package-versions)
[![Coverage Status](https://coveralls.io/repos/github/technote-space/gutenberg-package-versions/badge.svg?branch=master)](https://coveralls.io/github/technote-space/gutenberg-package-versions?branch=master)
[![CodeFactor](https://www.codefactor.io/repository/github/technote-space/gutenberg-package-versions/badge)](https://www.codefactor.io/repository/github/technote-space/gutenberg-package-versions)
[![License: GPL v2+](https://img.shields.io/badge/License-GPL%20v2%2B-blue.svg)](http://www.gnu.org/licenses/gpl-2.0.html)
[![PHP: >=5.6](https://img.shields.io/badge/PHP-%3E%3D5.6-orange.svg)](http://php.net/)
[![WordPress: >=5.0](https://img.shields.io/badge/WordPress-%3E%3D5.0-brightgreen.svg)](https://wordpress.org/)

This repository manages versions of Gutenberg.

```bash
composer require technote/gutenberg-package-versions
```

## Data
- `versions.json`
  - array of `tag` => `packages`
  - `packages`
    - `wp-<package>` => `version` 
```
{
  "v3.3.0": {
    "wp-a11y": "1.1.1",
    "wp-api-fetch": "1.0.1",
    "wp-autop": "1.1.1",
      
      ...
      
      "wp-url": "1.2.1",
      "wp-viewport": "1.0.1",
      "wp-wordcount": "1.1.1"
    }
  },
  
  ...
  
  "v5.9.1": {
    "wp-a11y": "2.3.0",
    "wp-annotations": "1.3.0",
    "wp-api-fetch": "3.2.0",
    
    ...
    
    "wp-url": "2.6.0",
    "wp-viewport": "2.4.0",
    "wp-wordcount": "2.3.0"
  },
  "v5.9.2": {
    "wp-a11y": "2.3.0",
    "wp-annotations": "1.3.0",
    "wp-api-fetch": "3.2.0",
    
    ...
    
    "wp-url": "2.6.0",
    "wp-viewport": "2.4.0",
    "wp-wordcount": "2.3.0"
  }
}
```
- `data/<TAG>.json`
  - `packages`
    - `wp-<package>` => `version` 

## Helper
```php
<?php

use Technote\GutenbergPackageVersion;

( new GutenbergPackageVersion() )->get_packages(); // array of (tag => packages)
( new GutenbergPackageVersion() )->get_packages( 'v5.2.0' ); // array of (package => version)

( new GutenbergPackageVersion() )->get_package_version( 'v5.1.0', 'wp-block-editor' ); // false
( new GutenbergPackageVersion() )->get_package_version( 'v5.2.0', 'wp-block-editor' ); // 1.0.0-alpha.0

( new GutenbergPackageVersion() )->package_exists( 'v5.1.0', 'wp-block-editor' ); // false
( new GutenbergPackageVersion() )->package_exists( 'v5.2.0', 'wp-block-editor' ); // true
```

## Author
[GitHub (Technote)](https://github.com/technote-space)  
[Blog](https://technote.space)
