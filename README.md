Mirror of nvidia-ml-py
======================

[nvidia-ml-py][] (`pynvml`) is the official python binding for NVIDIA's NVML library.
This repository hosts a mirror of the released version of `pynvml` libraries.

[nvidia-ml-py]: https://pypi.org/project/nvidia-ml-py/

Why?
----

`nvidia-ml-py` often breaks the backward compatibility, and the changelog (release note) is not very comprehensive.
This makes difficult for developers of downstream projects (e.g., [gpustat][], [nvitop][], etc.) depending on `pynvml` to deal with breaking changes in `pynvml`, and it is also difficult to know which version of `pynvml` end users might end up having installed due to the lack of `pynvml.__version__` string.

This repository is not supposed to be a "fork" of `nvidia-ml-py`, but exists only for the archiving purposes.
Users should NOT use this repository directly  or install `pynvml` from this repository.
This repository will be automatically synchronized with [the pypi repository][nvidia-ml-py] via Github Actions CI.

[gpustat]: https://github.com/wookayin/gpustat
[nvitop]: https://github.com/XuehaiPan/nvitop


Useful Links
------------

- https://pypi.org/project/nvidia-ml-py/#history


LICENSE
-------

BSD License (BSD), NVIDIA Corporation.
