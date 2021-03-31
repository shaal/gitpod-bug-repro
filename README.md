# upcoming-gitpod-docker-pull-bug-repro
This is a demonstration branch for reproducing https://github.com/gitpod-io/gitpod/issues/3671

To demonstrate the bug, 
Run this repo in Gitpod with prebuild option. Compare existing gitpod.io and the upcoming Gitpod
1. Existing Gitpod - https://gitpod.io/#prebuild/https://github.com/shaal/gitpod-bug-repro/pull/7
1. Upcoming Gitpod - https://main.staging.gitpod-dev.com/#prebuild/https://github.com/shaal/gitpod-bug-repro/pull/7 (or a similar dev build)

Results:
New (upcoming) Gitpod:
When gitpod.yml includes more than 1 docker pull during prebuild, if you open that workspace - the docker images and the generated files no longer exist.

Existing Gitpod:
No bugs, works as expected.
Running docker images displays the images loaded during prebuild
You can view file-created-during-prebuild.txt that was generated during prebuild.
