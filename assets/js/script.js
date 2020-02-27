var chemEditor;
var chemComposer;
const endpoint = 'http://127.0.0.1:5050/v2/run?ver=9&smiles=';


function init()
{
  var elem = document.getElementById('chemComposer');
  var chemEditor = new Kekule.Editor.ChemSpaceEditor(document, null, Kekule.Render.RendererType.R2D);
  chemComposer = new Kekule.Editor.Composer(elem, chemEditor);

  chemComposer.setEnableOperHistory(true)
  .setEnableLoadNewFile(true)
  .setEnableCreateNewDoc(true)
  .setAllowCreateNewChild(false)
  .setCommonToolButtons(['loadData', 'saveData', 'undo', 'redo', 'copy', 'cut', 'paste',
    'zoomIn', 'reset', 'zoomOut', 'objInspector'])   // create all default common tool buttons
  .setChemToolButtons(['manipulate', 'erase', 'bond', 'atomAndFormula',
    'ring', 'charge']);  // create only chem tool buttons related to molecule
}


function writeSmiles() {
  var molecules = chemComposer.exportObjs(Kekule.Molecule);

  if (molecules.length != 1) {
    document.getElementById("hiddenMessage").innerHTML = 'Error: Need single molecule!';
    document.getElementById("hiddenMessage").style.display = 'block';
    return;
  }

  var smiles = Kekule.IO.saveFormatData(molecules[0], 'smi');

  document.getElementById("hiddenMessage").innerHTML = 'Input smiles: ' + smiles;
  document.getElementById("hiddenMessage").style.display = 'block';

  smiles = smiles.replace('#', '%23')
  smiles = smiles.replace('+', '%2B')
  smiles = smiles.replace('-', '%2D')
  sendSmiles(smiles);
}


function resizeEditor() {
  var docwidth = document.getElementById('mainInput').offsetWidth;
  var svgstyle = '#chemComposer {width:' + docwidth + 'px; margin: 0;}';
  // console.log(svgstyle);
  document.getElementById('editorStyle').innerHTML = svgstyle;
}


function resizeSVG() {
  var docwidth = document.getElementById('displayResults').offsetWidth;
  var docheight = Math.round(docwidth * 0.6);
  var svgstyle = 'svg {width:' + docwidth + 'px; height:' + docheight + 'px;}';
  document.getElementById('svgStyle').innerHTML = svgstyle;
}


function sendSmiles(smiles) {
  const request = new XMLHttpRequest();
  querypoint = endpoint + smiles;

  request.open('GET', querypoint, true)
  request.onload = function() {
    var data = JSON.parse(this.response)

    if (request.status >= 200 && request.status < 400) {
      document.getElementById('result').innerHTML = data.svg;
      // console.log(data.time);
      // console.log(data.bonds);
    } else {
      console.log('error')
    }
  }

  request.send();
}


Kekule.X.domReady(init);
console.log("Live");
re = /[a-z]+$/


window.addEventListener("resize", function(event) {
    // console.log(document.body.clientWidth + ' wide by ' + document.body.clientHeight+' high');
    loc = document.documentURI.match(re)[0];
    if (loc == "run") {resizeEditor();}
    if (loc == "results") {resizeSVG();}
})
