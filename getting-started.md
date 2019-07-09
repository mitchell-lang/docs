---
nav_order: 2
---
# Getting Started
{:.no_toc}

1. Generated Toc
{:toc}

## Connecting to the Evaluation Docker Container

To connect to the Mitchell evaluation servers, you will need an SSH client and a
VNC client.

### Forwarding the VNC Port Using SSH

To securely connect to the container using the VNC client, you must first forward
the VNC port (5999) from the server to your local machine using SSH. To do so,
run the following command, replacing `$VM_IP` with the IP address of the
machine to which you are connecting and `$SSH_KEY` with the path to the SSH key
that you were given.

```bash
ssh -L 127.0.0.1:5999:localhost:5999 \
    -o IdentitiesOnly=yes \
    -F /dev/null \
    -i "$SSH_KEY" \
    "ubuntu@$VM_IP"
```

Once connected, run the `startEval.sh` script to launch the Docker container
containing the evaluation environment:

```bash
sh startEval.sh
```

You will see output like the following:

```
/usr/bin/xauth:  file /home/mitchell/.Xauthority does not exist

New 'b3ad2054723d:99 (mitchell)' desktop at :99 on machine b3ad2054723d

Starting applications specified in /home/mitchell/.vnc/xstartup
Log file is /home/mitchell/.vnc/b3ad2054723d:99.log

Use xtigervncviewer -SecurityTypes VncAuth,TLSVnc -passwd
/home/mitchell/.vnc/passwd b3ad2054723d:99 to connect to the VNC server.
```

At that point, you can connect to the container using a VNC client, as described below.

Note: the `README` file on the machine contains an error in its description of
how to stop the Docker container. To stop the Docker container, first disconnect
from the running container by typing `CTRL+p CTRL+q`. Then run `sudo sh
stopEval.sh`. You can confirm that the container has been stopped by running
`sudo docker ps`.

### Windows

Download and install [TightVNC](https://www.tightvnc.com/).

Run the TightVNC Viewer for Windows. Connect to `localhost:99`.
The password for the VNC connection is `mitchell`.

### Mac

Mac has a built-in VNC client. Open a Finder window or click on your desktop, so
that "Finder" shows in the top-left menu. Then choose in the menu "Go > Connect
to Server". In the window that pops up, put `vnc://localhost:5999`

A login window should pop up asking for your password. The password for VNC is
`mitchell`.

### Linux

On Linux we recommend installing and using the tightvnc package.

```bash
sudo apt-get install xtightvncviewer
xtightvncviewer localhost:99
```

The password for the VNC connection is `mitchell`.

### Resizing the Screen

By default the VNC server uses a 1280x720 screen size. You can resize the
screen to 1920x1080 by running the following in a terminal in the container:

```bash
xrandr --size 1920x1080
```

## Using the Evaluation Virtual Machine

### Editing Mitchell Files

The virtual machine has Visual Studio Code with a plugin for providing syntax
highlighting for the Mitchell language already installed. Open Visual Studio
Code by clicking on the icon in the dock at the bottom of the screen.

In Visual Studio Code, click on the File menu, and choose "New File". Save the
file in the `/data` directory and name it `hello-world.sml`. You may have to
scroll down in the file browser to find the `/data` directory.

Mitchell files use the `.sml` file extension and "Standard ML" Visual Studio
Code editing mode for highlighting. You should see the words "Standard ML" in
the lower right corner of the Visual Studio Code window.

### Saving Your Work

On the virtual machine, save anything that you want to keep in the `/data`
directory, not in your home directory (i.e., not in `~` or `/home/mitchell`). If
we need to update the virtual machine during the evaluation exercise, data
outside of the `/data` directory will not be preserved.

## Creating Your First Mitchell Program

In the `hello-world.sml` file, write

```sml
val _ = print "Hello world!\n";
```

and save the file.

Every statement in a Mitchell program returns a value, however the `print`
function does not return value that you need. If you do not need the value
returned by a statement or expression, you can assign it to `_` (underscore) to
throw it away.

## Running Your First Mitchell Program

Open the terminal by clicking on the icon in the dock. Type

```bash
cd /data
run-mitchell hello-world.sml
```

You should see `Hello world!` printed on the screen.

## Running Mitchell Programs for the Assigned Workloads

For the tutorials, we have provided you with two scripts to aid in compiling and
running Mitchell programs: `run-mitchell` and `check-mitchell`, both of which
are on your `PATH`. These work well for single-file programs, which is
what you will be writing while doing the tutorial exercises.

The assigned workloads are larger, multi-file, programs of which you are writing
only part. Instead of using `run-mitchell` and `check-mitchell`, each assigned
workload includes a Makefile that can be used to acquire and prepare the test
data, to build your program, to run your program, and to run the validation
scripts on the program output.

Before using the Makefile, run

```bash
source install.sh
```

to set up the Python Conda environment required for the data preparation and
output validation scripts.

The two `make` commands that will be particularly useful are:

- To build your program, which you should do often to check for compilation
  errors:

    ```bash
    make
    ```

- To build and run your program and check the output (this will acquire and prepare the
  test data automatically):

    ```bash
    make evaluate
    ```

## Alternative to VNC

Since most editing environments do not come with built-in support for syntax
highlighting that is compatible with Mitchell, we recommend using the Visual
Studio Code installation available on the image via VNC.

If you cannot use VNC, it is possible to start a Docker image that is just
running a shell. Because the `/data` directory is a mount point, you can edit
the files from the host machine (or edit them locally and upload the new files),
and the changes will appear in the Docker container.

You may omit the `-L` flag and its arguments when connecting to the host
machine.

```
ssh -o IdentitiesOnly=yes \
    -F /dev/null \
    -i "$SSH_KEY" \
    "ubuntu@$VM_IP"
```

To start a Docker container with the same content as the VNC server but that is
just running a bash shell, run

```
sudo docker run --privileged -it --rm -v /data:/data sdhph1-eval1 /bin/bash
```

Once in the container, in order to switch to the `mitchell` user (necessary to
have the correct `PATH` and other environment variables), run

```
su --login mitchell
```

If you wish to edit your program from within the container (e.g., using Vim or
Emacs), you will need to change the permissions on the files before switching to
the `mitchell` user. This can be accomplished by running:

```
chown -R mitchell:mitchell /data
```

However, doing this will change the permissions on the host machine as well. If
you wish to edit the files from the host machine, you may need to reset the
permissions before doing so.

If you are editing Mitchell programs locally, you may wish to use
[this Visual Studio Code plugin](https://marketplace.visualstudio.com/items?itemName=freebroccolo.sml),
which is compatible with Mitchell. Additionally, the `sml-mode` package for
Emacs (available on ELPA) is compatible with Mitchell, though it may require
additional configuration (which is not covered in this documentation).

## Next Steps

- Learn the syntax of Mitchell and Standard ML at
    [Learn X in Y Minutes](https://learnxinyminutes.com/docs/standard-ml/).
- Go through the first few chapters of
    [Programming in Standard ML '97: An On-line Tutorial](http://homepages.inf.ed.ac.uk/stg/NOTES/node2.html).
- Follow along with the Gradient Boosted Decision Trees implementation
    [walkthrough](tutorials/tutorial-gbdt.md) to learn how to write a machine
    learning algorithm in Mitchell.
- Follow along with the IO and Parsing implementation
    [walkthrough](tutorials/tutorial-io-parsing.md) to learn how to read
    simple data formats into a Mitchell program.
