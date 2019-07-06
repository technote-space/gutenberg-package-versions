# Gutenberg Package Versions

[![Build Status](https://travis-ci.com/technote-space/gutenberg-package-versions.svg?branch=master)](https://travis-ci.com/technote-space/gutenberg-package-versions)
[![CodeFactor](https://www.codefactor.io/repository/github/technote-space/gutenberg-package-versions/badge)](https://www.codefactor.io/repository/github/technote-space/gutenberg-package-versions)
[![License: GPL v2+](https://img.shields.io/badge/License-GPL%20v2%2B-blue.svg)](http://www.gnu.org/licenses/gpl-2.0.html)

This repository manages versions of Gutenberg.

## Raw data
- `package.json` of Gutenberg
  - data/tags/`<TAG>`/package.json
- `package.json` of each package
  - data/tags/`<TAG>`/packages/`<package>`.json

## Processed data
- merged all package's `package.json`
  - data/versions/`<TAG>`/packages.json
- `package => version`
  - data/versions/`<TAG>`/versions.json

## Author
[GitHub (Technote)](https://github.com/technote-space)  
[Blog](https://technote.space)
