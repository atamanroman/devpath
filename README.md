#devpath

Simple tool for analyzing the PATH variable on linux/windows machines. Lists the following:

* stale entries (listed in $PATH but not on disk)
* duplicate entries
* content of $PATH
* all folders in $PATH
* all relevant entries (executables and libs)

##usage
    ruby devpath.rb #or
    ./devpath.rb
