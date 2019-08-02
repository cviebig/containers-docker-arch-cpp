Docker build and runtime environment
====================================

This directory provides a set of short shell scripts intended to create a
convenient environment in which the projects can be build and run. Each file
implements a specific action and is named accordingly using verbs. The behavior
of the scripts is controlled by both environment variables and command line
arguments.

Environment variables
---------------------

There are five environment variables that control certain aspects of the
scripts:

``PROJECT_NAME``
  Name of the project which is going to be used as an identifier for Docker
  images and as part of directory names if the paths ``BUILD_DIR`` and
  ``OUTPUT_DIR`` are not set. The default is ``projcpp``.

``BUILD_DIR``
  Directory in which build system maintains it's state and to which artifacts
  such as object files, static and dynamic libraries as well as executables are
  produced. Inside the container this is mapped to ``/home/user/build``. The
  default is ``$HOME/tmp/${PROJECT_NAME}_build``.

``OUTPUT_DIR``
  Directory that is going to be used by binaries to store their files in. Inside
  the container this is mapped to ``/tmp``. The default is
  ``$HOME/tmp/${PROJECT_NAME}``.

``CXX``
  Path to the C++-compiler. This is may be for example ``g++`` or ``clang++``.

``CC``
  Path to the C++-compiler. This is may be for example ``gcc`` or ``clang``.

Actions
-------

setup
  Invoke Docker to pull the latest ``archlinux/base`` image from the hub and
  build all derived images needed to build the project and execute any
  artifacts. The images are installed under the repository name ``projsql``.
  This action supports the ``--no-cache`` option of ``docker build`` and
  forwards it if it is passed as the first command line argument.

configure
  Invoke the build system CMake to setup the build directory and configure the
  build. The action takes one command line argument to determine the build type
  to choose. This can be either ``Release``, ``RelWithDebInfo``, or ``Debug``.
  CMake is configured to generate build files for Ninja. The source tree
  including ``CMakeLists.txt`` is expected to exist in the parent directory.

build
  Invoke the build system Ninja on the configured build directory. Any command
  line argument provided is passed to the ``ninja`` executable.

execute
  Execute a binary with a path relative to the build directory. Any command line
  argument provided is passed to the executable.

run
  Run a program on a specified Docker image. The first command line argument
  specifies the Docker image to create the container from. The second command
  line argument specifies the executable to run and any subsequent command line
  argument is passed to the executable.

cleanup
  Remove any left over Docker containers that have been stopped or have exited
  as well as any Docker images older than the most recent one.

remove
  Remove any Docker container or image existing on the system, even if they are
  still in use. In that case they are shutdown and forcibly removed.

Playbook example
----------------

.. code-block:: sh

  export PROJECT_NAME=projcpp
  export BUILD_DIR=$HOME/tmp/projcpp_build
  export OUTPUT_DIR=$HOME/tmp/projcpp
  export CXX=/usr/bin/clang++
  export CC=/usr/bin/clang
  ./setup
  ./configure Release
  ./build TARGET
  ./execute EXECUTABLE args
  ./execute valgrind --tool=memcheck --leak-check=full /home/user/build/PATHTO/EXECUTABLE args
  ./cleanup
  ./remove


Docker images
-------------

base
  Derives from the official ArchLinux Docker image, updates the mirror list,
  updates the system packages, installs ``sudo``, sets up a new user ``build``,
  allows it to invoke ``sudo`` without authentication, sets the Docker working
  directory to the new user's home directory and chooses this user to be the one
  under which processes are started by default.

develop
  Derives from the base image and installs official ArchLinux packages
  ``base-devel``, ``boost``, ``catch2``, ``clang``, ``cmake``, ``gcc``, ``gdb``,
  ``git``, ``llvm``, ``ninja``, ``valgrind``. Adds ``Docker`` volumes to paths
  ``/home/user/project``, ``/home/user/build``, ``/tmp``.

runtime
  Derives from the base image and installs the official ArchLinux package
  ``boost``. Adds Docker volumes to paths ``/home/user/project``,
  ``/home/user/build``, ``/tmp``.
