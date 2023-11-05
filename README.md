<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]


<h3 align="center">awesomewm-basileia</h3>

  <p align="center">
    Minimalist and easy to expand AwesomeWM configuration with possible <a href="https://github.com/elkowar/eww"> Eww</a> integraion.
    <br />
    <br />
    <a href="https://github.com/straightchlorine/awesomewm-basileia/issues">Report Bug</a>
  </p>
</div>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about">About</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#examples">Examples</a></li>
    <li>
      <a href="#eww-integration">Eww integration</a>
      <ul>
        <li><a href="#eww-example">Example</a></li>
        <li><a href="#eww-warning">Warning</a></li>
      </ul>
    </li>
    <li><a href="#personalization">Personalization</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li>
      <a href="#resources">Resources</a>
      <ul>
        <li><a href="#resources-config">Configuration</a></li>
        <li><a href="#resources-wallpaper">Wallpaper</a></li>
      </ul>
    </li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
<a name="about"></a>
## About

[![awesomewm-basileia][product-screenshot]](https://example.com)

Basileia is a simple configuration for AwesomeWM.

It's main objective is to keep things as simple as possible, so it's easy to change, add and personalise any aspect of the environment.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<a name="getting-started"></a>
<!-- GETTING STARTED -->
## Getting Started

### Prerequisites
<a name="prerequisites"></a>
* Ensure that you have 
<a href="https://github.com/awesomeWM/awesome" target="_blank">awesome-git</a>
installed.
* For network traffic widgets,
<a href="https://github.com/vergoh/vnstat" target="_blank">vnStat</a>
is required.
* Music widget works only with 
<a href="https://github.com/MusicPlayerDaemon/MPD" target="_blank">MPD</a>
via
<a href="https://www.musicpd.org/clients/mpc" target="_blank">mpc</a>.
* Battery widget utilises basic `acpi` utility, available in most package managers.

<a name="installation"></a>
### Installation

Installation is very straightforward, the only thing you need to do is to clone this repository to `~/.config/awesome`
folder:
   ```sh
   git clone https://github.com/straightchlorine/awesomewm-basileia.git ~/.config/awesome
   ```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- EXAMPLES -->
<a name="examples"></a>
## Examples

Multihead setup:

[![awesomewm-basileia][product-screenshot-multihead]](https://example.com)

Laptop:

[![awesomewm-basileia][product-screenshot-laptop]](https://example.com)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="eww-integration"></a>
### Eww integration
If for whatever reason you wish to use Eww integration feature, you need to [install Eww](https://elkowar.github.io/eww/eww.html) first. 

Default path of the installation is defined (for now) in `configuration/scripts/eww-run` 
file and points to `~/.local/share/eww/target/release/eww`. 

All the code responsible for the communication with Eww widgets is located within `utility/eww` module. 
Of course you can customise it according to your needs.

Currently, the communication is very simple - proceeds via logging information to files in `~/.cache/awesomewm/` folder.

First file is called `tag-overview` and contains JSON image of every tag (workspace) i.e. number of windows, it's ID and
display to which it's assigned to.

Second type of file that is created depends on number of displays, which are connected. For example `1-active-tag`
corresponds to the active workspace on the first display.

By default `Mod + e` corresponds to toggling widget setup.

<a name="eww-example"></a>
### Example

Configuration below uses [my Eww configuration](https://github.com/straightchlorine/x11-eww-widgets), which is functional, but still very much work in progress both in terms of documentation and code itself.

[![awesomewm-basileia-eww][product-screenshot-eww]](https://example.com)

Note that this bar is heavily inspired by [end4's hyprland configuration](https://github.com/end-4/dots-hyprland)
and was initially written for [Wayland](https://wayland.freedesktop.org/). 

<a name="eww-warning"></a>
#### Warning

It is a <b>very primitive</b> and not ideal solution. You absolutely <b>should</b> use widgets native to AwesomeWM. They simply work better with the entire ecosystem.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Personalization -->
<a name="personalization"></a>
## Personalization

The goal of the configuration is to keep things simple, so it's easy to configure and does not overwhelm with features. 

That being said, if you want to change anything, I strongly recommend testing the configuration before
restarting the environment.

In order to do that you can use `Xephyr` --- a nested X server, which allows you to run your configuration 
in a separate X server and ensure that everything is correct without risking stability of your currently running
instance of AwesomeWM.

I used the following script from [archwiki](https://wiki.archlinux.org/title/awesome#Automatic_reload):
```
#/bin/bash

Xephyr :1 -ac -br -noreset -screen 852x480 -dpi 96 &

sleep 1
DISPLAY=:1.0 awesome -c ~/.config/awesome/rc.lua &
instance=$!

while inotifywait -r -e close_write ~/.config/awesome; do
	kill -s SIGHUP $instance
done
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->
<a name="roadmap"></a>
## Roadmap

- [ ] Dynamic and quick colorscheme changes via external script (work in progress).
- [ ] Simple popup calendar widget.
- [ ] Simple popups for other existing widgets.
- [ ] Rewrite existing bash scripts in Lua.
- [ ] Move all hardcoded variables to `utility/environment.lua`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->
<a name="contributing"></a>
## Contributing

The project is meant to be a base for more elaborate and personalised configuration. Naturally it's open for suggestions and fixes, which you can propose via issues or pull requests.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
<a name="license"></a>
## License

Distributed under the GPL-3.0 License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- Resources -->
<a name="resources"></a>
## Resources

<a name="resources-config"></a>
### Configuration
Project is still very much in progress. And will likely be for quite a long time. If what you need is a
beautiful and mature configuration for AwesomeWM, try out the following:

* <a href="https://github.com/rxyhn/yoru" target="_blank">yoru by rxyhn</a>
* <a href="https://github.com/elenapan/dotfiles" target="_blank">dotfiles by elenapan</a>

Those configurations are amazing not only for everyday use, but also are great resources to learn how to
configure the window manager.

`README` was created using this [template](https://github.com/othneildrew/Best-README-Template).

<!-- Wallpaper -->
<a name="resources-wallpaper"></a>
### Wallpaper

* <a href="https://img3.gelbooru.com/images/63/f5/63f5eb95255009bbf81ff41b8cb8e9b4.png" target="_blank">Wallpaper</a>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-url]: https://github.com/straightchlorine/awesomewm-basileia/blob/master/LICENSE
[linkedin-url]: https://www.linkedin.com/in/straightchlorine/
[issues-url]: https://github.com/straightchlorine/awesomewm-basileia/issues

[issues-shield]: https://img.shields.io/github/issues/straightchlorine/awesomewm-basileia.svg?style=for-the-badge
[license-shield]: https://img.shields.io/github/license/straightchlorine/awesomewm-basileia.svg?style=for-the-badge
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555

[product-screenshot]: img/preview.png
[product-screenshot-multihead]: img/preview-multihead.png
[product-screenshot-laptop]: img/preview-laptop.png
[product-screenshot-eww]: img/preview-eww.png
