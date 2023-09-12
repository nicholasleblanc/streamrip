# streamrip

A scriptable stream downloader for Qobuz and Tidal.

![Streamrip downloading an album](https://github.com/nathom/streamrip/blob/dev/demo/download_album.png?raw=true)

## Features

- Super fast as it utilizes concurrent downloads
- Downloads tracks, albums, playlists, discographies, and labels from Qobuz and Tidal
- Has a database that stores the downloaded tracks' IDs so that repeats are avoided
- Easy to customize with the config file

## Usage

Firstly, create the docker image locally:

```bash
docker build -t rip .
```

Secondly, you will need to ensure you have a directory for your config and downloads. We need to ensure we have a copy of `config.toml` in the config directory.

```bash
mkdir config
cp rip/config.toml config
mkdir downloads
```

Finally, use docker to access the image. Here are some example snippets to help you get started creating a container.

### docker-compose

```yaml
---
version: '3.8'

services:
  rip:
    container_name: rip
    image: rip:latest
    restart: no
    volumes:
      - ./config:/config
      - ./downloads:/downloads
```

### docker cli (recommended)

```bash
docker run \
  -v /path/to/config:/config \
  -v /path/to/downloads:/downloads \
  -it rip
  rip --help
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

|    Parameter    | Function                                                           |
| :-------------: | ------------------------------------------------------------------ |
|  `-v /config`   | Rip configuration. Should at minimum contain a `config.toml` file. |
| `-v /downloads` | Any music downloaded will be stored in this folder.                |

## Example Usage

**For Tidal and Qobuz, you NEED a premium subscription.**

Download an album from Qobuz

```bash
rip url https://www.qobuz.com/us-en/album/rumours-fleetwood-mac/0603497941032
```

Download multiple albums from Qobuz

```bash
rip url https://www.qobuz.com/us-en/album/back-in-black-ac-dc/0886444889841 https://www.qobuz.com/us-en/album/blue-train-john-coltrane/0060253764852
```

To set the maximum quality, use the `--max-quality` option to `0, 1, 2, 3, 4`:

| Quality ID | Audio Quality         | Available Sources  |
| ---------- | --------------------- | ------------------ |
| 0          | 128 kbps MP3 or AAC   | Tidal,             |
| 1          | 320 kbps MP3 or AAC   | Tidal, Qobuz       |
| 2          | 16 bit, 44.1 kHz (CD) | Tidal, Qobuz       |
| 3          | 24 bit, ≤ 96 kHz      | Tidal (MQA), Qobuz |
| 4          | 24 bit, ≤ 192 kHz     | Qobuz              |

```bash
rip url --max-quality 3 https://tidal.com/browse/album/147569387
```

![streamrip interactive search](https://github.com/nathom/streamrip/blob/dev/demo/album_search.png?raw=true)

Search for _Rumours_ on Tidal, and download it

```bash
rip search 'fleetwood mac rumours'
```

Want to find some new music? Use the `discover` command (only on Qobuz)

```bash
rip discover --list 'best-sellers'
```

For extreme customization, see the config file

```
rip config --open
```

If you're confused about anything, see the help pages. The main help pages can be accessed by typing `rip` by itself in the command line. The help pages for each command can be accessed with the `-h` flag. For example, to see the help page for the `url` command, type

```
rip url -h
```

![example_help_page.png](https://github.com/nathom/streamrip/blob/dev/demo/example_help_page.png?raw=true)

## Other information

For more in-depth information about `streamrip`, see the help pages and the [wiki](https://github.com/nathom/streamrip/wiki/).

## Contributions

All contributions are appreciated! You can help out the project by opening an issue
or by submitting code.

### Setup

Requirements:

- Python v3.8+
- [poetry](https://python-poetry.org/)

```bash
poetry install
```

### Running in development

```bash
poetry run rip search --type=artist "lil wayne"
poetry run flake8
```

## Acknowledgements

Thanks to Vitiko98, Sorrow446, and DashLt for their contributions to this project, and the previous projects that made this one possible.

`streamrip` was inspired by:

- [streamrip](ttps://github.com/nathom/streamrip)
- [qobuz-dl](https://github.com/vitiko98/qobuz-dl)
- [Qo-DL Reborn](https://github.com/badumbass/Qo-DL-Reborn)
- [Tidal-Media-Downloader](https://github.com/yaronzz/Tidal-Media-Downloader)
- [scdl](https://github.com/flyingrub/scdl)

## Disclaimer

I will not be responsible for how you use `streamrip`. By using `streamrip`, you agree to the terms and conditions of the Qobuz and Tidal APIs.
