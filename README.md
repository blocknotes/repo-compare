# Repo Compare
[![gem version](https://badge.fury.io/rb/repo-compare.svg)](https://badge.fury.io/rb/repo-compare) [![specs](https://github.com/blocknotes/repo-compare/actions/workflows/specs.yml/badge.svg)](https://github.com/blocknotes/repo-compare/actions/workflows/specs.yml)

Track changes of another repository.

Features:
- check multiple paths of a repo;
- create a summary of the changes using git compare (`-s` option);
- create a detailed list of diffs;
- ignore some changes to a specific file, saving hashes locally (`-u` option).

It can be useful keep track of the changes of a master repo from a forked project, eventually preparing a check in the CI.

**IMPORTANT**: the tool will add the other repository as remote source.

## Installation

- Add to your Gemfile: `gem 'repo-compare', require: false` (and execute `bundle`)
- Create a config file in the root of your project (`.repo-compare.yml`):

```yml
---
source_name: REPO_NAME
source_branch: master
source_base_path: OPTIONAL_INTERNAL_PATH
source_repo: https://github.com/ACCOUNT_NAME/REPO_NAME.git
paths:
  - PATH1
  - PATH2
  - PATH3
  - ...
```

- Execute the binary: `bundle exec repo-compare`

Alternative option, install it at system level: `gem install repo-compare`

## Usage

The tool accepts some command line option:

- `-h` or `--help`    : show this help
- `-s` or `--summary` : generate an XML summary of the files changed (useful for CI)
- `-u` or `--update`  : update the config file setting the current hashes to ignore

## Do you like it? Star it!

If you use this component just star it. A developer is more motivated to improve a project when there is some interest.

Or consider offering me a coffee, it's a small thing but it is greatly appreciated: [about me](https://www.blocknot.es/about-me).

## Contributors

- [Mattia Roccoberton](https://blocknot.es/): author

## License

The gem is available as open source under the terms of the [MIT License](MIT-LICENSE).
