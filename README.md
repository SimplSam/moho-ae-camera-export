# moho-ae-camera-export
SimplSam's **AE Camera Export** is a Moho tool that allows you to export Camera property & keyframe data to the **clipboard**, ready for pasting directly to Adobe After Effects.

![img](https://i.ibb.co/L51hqW7/mh-camera-keyframes.png)

It was designed as an _upgrade_ / companion to the excellent earlier **DS Camera to AE** tool - created by David F. Sandberg (aka. ponysmasher) - https://www.dauid.com, and complements it with these new & alternate features:

- Instantly **Saves Camera data to the Clipboard** (instead of a file); ready for pasting
- Can be run as a Button or Menu Tool
- Reduces data size by eliminating redundant keyframes (does not bake multiple keyframes if the property only has a single value)
- Has a modular code refactor

![img](https://i.ibb.co/wh3sdZ1/ae-cam-stats.png)

### So ... Why do you need AE Camera Export ? ###

The tool allows the efficient sharing of Camera configuration and keyframed positioning information from Moho to After Effects, which helps greatly when your animation workflow (finalizing, SFXing or compositing) includes one or more trips from Moho -> Ae. Thus allowing Camera movement & properties to be easily synchronized (_one-way_).

![img](https://i.ibb.co/PMLQ8Gd/ae-cam-config.png)

### Version ###

* version: 2.0 #520114 MH12+
* release: v2.00
* by Sam Cogheil (SimplSam)

### How do I get set up ? ###

* To install:

  - Download latest release: [ss_ae_camera_export.zip](https://github.com/SimplSam/moho-ae-camera-export/releases/latest/download/ss_ae_camera_export.zip)
  - Save the 'ss_ae_camera_export.lua' and 'ss_ae_camera_export.png' files to your computer into your &lt;custom&gt;/scripts/tool folder  (or under scripts/menu)
  - Reload Moho scripts (or Restart Moho)

* To use:

  - Run the **AE Camera Export+** tool from the Tools palette or Menu location
  - If you need to view/amend the data before passing to AE, you can paste into a Excel/Spreadsheet or Text editor


### Options & Features ###
\*\* Currently there are no options.


### Notes & Limitations ###

There appears to be a bug in AS11 which limits the size of text passed to the Clipboard to 4096 bytes. Thus AS11 is not fully compatible with this tool.

Because the 'DS Camera to AE' tool fully baked the Camera movement (_wrote every possible keyframe_), it would always overwrite all previous settings. This tool is keyframe data optimized and only writes required keyframes. So you may occasionally need to clear old-keyframes (deselect the stop-watches or delete keyframes) before use.

Additional Notes:

* Compatible/Tested with MH12+
* Optimized for MH12+

&nbsp;


## Special Thanks to: ##

* David F. Sandberg (ponysmasher) -- https://www.dauid.com
* Stan (and the team): MOHO Scripting -- https://mohoscripting.com
* The friendly faces @ Lost Marble Moho forum -- https://www.lostmarble.com/forum/
