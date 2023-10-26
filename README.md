# QR-tags-generation
Generates printable QR codes from GeoJSON

The code in genera.sh and split_geojson.py is obsolete, and their functions are replaced by qrcode-gen.html. They are kept in place since referenced in the preprint of the paper https://doi.org/10.20944/preprints202310.1533.v1 .

## Usage
The qrcode-gen tool is run by clocking two times on the file icon, or reaching the file with the browser (file:///.../qrcode-gen.html), and does not require an Internet connection.

There are two operation options available, that are selected in the opening dialog:

### Create uMap file from template
Three data are required in a dialog:
* the prefix of the URL linked to the QR tag;
* the geoJSON file containing the point features to be included in the map;
* the uMap file with to configure the visualization on the uMap service.

The tool creates a new uMap file using the geoJSON file containing a *featureCollection* with all the *Points* in the map. The tool integrates the points with the properties needed to create and visualize a QR tag. The properties are the following:
* name: the title of the QR tag, usually the name of the location;
* description: the description encoded in the tag;
* fid: the unique, random identifier associated with the tag. It is used to generate the URL of the associated Web page;
* urlPrefix: the prefix for the URL of the associated Web page;
* imageTag: the variable part of the link to the associated image in the Google drive. It is the part here highlighted: drive.google.com/file/d/ **1OgXyEO1g_Jq7rvVQX0otMgPOrCfGLqvZ** /view?usp=sharing;

In case the fields are already present they are left untouched. Otherwise, they are created and filled with a default value: the *fid* receives a new random six characters id, the *urlPrefix* is set to the value indicated by the user in the dialog, and the other fields (*name*, *description* and *title*) are initialized to the empty string.

The points contained in the featureCollection are wrapped into a template, which is also indicated by the user in the dialog. The template configures the visualization and animation of the map, once uploaded to uMap

### Create tags form uMap file
The tool produces a svg image containing the QR tags corresponding to the points described in the file indicated in the dialog.
An intermediate step consists in the visualization of a table containing all the links in the tags and the associated images, and a preview of the tags. The table can be used to verify that the links are alive and correct, while the image can be checked for overflows or errors.
Pressing the Download button the image is downloaded. The user is prompted with the specs of the image, helpful to print and cut the tags.

### Suggested workflow.

* The workflow starts with a geoJSON containing a feature collection with points. This can be generated in any way: by hand, using tools like QGis, uMap, or GaiaGPS or converted from other formats (Google Maps).
The geoJSON file is processed with qrcode-gen.html using the Create uMap option-
* The output file is loaded into a new uMap map, and the empty fields are filled with user information and the result is downloaded as a uMap file ("Full Map"), and overwritten to the original geoJSON
* The file is processed with qrcode-gen.html using the Create Tags option. All the links in the table should be checked for consistency and the tags review should be visually checked and possibly scanned.
* The svg file produced in the previous step is saved and printed using the information provided on-screen.

The files to be archived are:
- the geoJSON file, which is useful to replace the original uMap template and rebuild a map;
- the uMap template file, useful to rebuild the uMap file and for reuse in other itineraries;
- the uMap file, useful to rebuild the map delivered by the uMap service
- the tags.svg file, useful to produce further copies
- the uMap file,  
