# Repo Compare
[![gem version](https://badge.fury.io/rb/repo-compare.svg)](https://badge.fury.io/rb/repo-compare)
[![linters](https://github.com/blocknotes/repo-compare/actions/workflows/linters.yml/badge.svg)](https://github.com/blocknotes/repo-compare/actions/workflows/linters.yml)
[![specs](https://github.com/blocknotes/repo-compare/actions/workflows/specs.yml/badge.svg)](https://github.com/blocknotes/repo-compare/actions/workflows/specs.yml)

This is an example branch used to illustrate how the tool works.

Steps:
- setup the configuration file: [.repo-compare.yml](.repo-compare.yml);
- execute the binary: `bundle exec repo-compare`

This will initially add a new remote repository to make the comparison, example:
```
origin	git@github.com:blocknotes/repo-compare.git (fetch)
origin	git@github.com:blocknotes/repo-compare.git (push)
repo-compare	https://github.com/blocknotes/repo-compare.git (fetch)
repo-compare	https://github.com/blocknotes/repo-compare.git (push)
```

To create the summary execute: `bundle exec repo-compare -s`

To update the local config file and ignore the last changes: `bundle exec repo-compare -u`

Take a look to the [.repo-compare.yml](.repo-compare.yml) config file for extra options. Any file can be ignored using `"-"` in the `ignore` list.

There's also an example GitHub action: [compare](https://github.com/blocknotes/repo-compare/actions/workflows/compare.yml)

### Standard output

The output of `bundle exec repo-compare` will be like:

```diff
diff --git a/.rspec b/.rspec
deleted file mode 100644
index 5be63fc..0000000
--- a/.rspec
+++ /dev/null
@@ -1,2 +0,0 @@
---require spec_helper
---format documentation
diff --git a/lib/new_file.txt b/lib/new_file.txt
new file mode 100644
index 0000000..0ee3895
--- /dev/null
+++ b/lib/new_file.txt
@@ -0,0 +1 @@
+Some content
diff --git a/spec/spec_helper.rb b/spec/spec_helper.rb
index faadb3c..aee032d 100644
--- a/spec/spec_helper.rb
+++ b/spec/spec_helper.rb
@@ -7,10 +7,8 @@ RSpec.configure do |config|
   config.expect_with :rspec do |expectations|
     expectations.include_chain_clauses_in_custom_matcher_descriptions = true
   end
-
   config.mock_with :rspec do |mocks|
     mocks.verify_partial_doubles = true
   end
-
   config.shared_context_metadata_behavior = :apply_to_host_groups
 end
```
