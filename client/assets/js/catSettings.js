
var colors = Object.values(allColors())

var defaultDNA = {
  "headcolor": 10,
  "mouthColor": 13,
  "eyesColor": 96,
  "earsColor": 10,
  //Cattributes
  "eyesShape": 1,
  "decorationPattern": 1,
  "decorationMidcolor": 13,
  "decorationSidescolor": 13,
  "animation": 1,
  "lastNum": 1
}

// when page load
$(document).ready(function () {
  $('#dnabody').html(defaultDNA.headColor);
  $('#dnamouth').html(defaultDNA.mouthColor);
  $('#dnaeyes').html(defaultDNA.eyesColor);
  $('#dnaears').html(defaultDNA.earsColor);

  $('#dnashape').html(defaultDNA.eyesShape)
  $('#dnadecoration').html(defaultDNA.decorationPattern)
  $('#dnadecorationMid').html(defaultDNA.decorationMidcolor)
  $('#dnadecorationSides').html(defaultDNA.decorationSidescolor)
  $('#dnaanimation').html(defaultDNA.animation)
  $('#dnaspecial').html(defaultDNA.lastNum)

  renderCat(defaultDNA)
});

function getDna() {
  var dna = ''
  dna += $('#dnabody').html()
  dna += $('#dnamouth').html()
  dna += $('#dnaeyes').html()
  dna += $('#dnaears').html()
  dna += $('#dnashape').html()
  dna += $('#dnadecoration').html()
  dna += $('#dnadecorationMid').html()
  dna += $('#dnadecorationSides').html()
  dna += $('#dnaanimation').html()
  dna += $('#dnaspecial').html()

  return parseInt(dna)
}

function renderCat(dna) {
  headColor(colors[dna.headcolor], dna.headcolor);
  $('#bodycolor').val(dna.headcolor);
  mouthColor(colors[dna.mouthColor], dna.mouthColor);
  $('#mouthcolor').val(dna.mouthColor);
  eyesColor(colors[dna.eyesColor], dna.eyesColor);
  $('#eyescolor').val(dna.eyesColor);
  earsColor(colors[dna.earsColor], dna.earsColor);
  $('#earscolor').val(dna.earsColor);
  decorationMidcolor(colors[dna.decorationMidcolor], dna.decorationMidcolor);
  $('#decorationMid').val(dna.decorationMidcolor);
  decorationSidescolor(colors[dna.decorationSidescolor], dna.decorationSidescolor);
  $('#decorationSides').val(dna.decorationSidescolor);
  animationVariation(dna.animation);
  $('#animation').val(dna.animation);

}

// Changing cat colors
$('#bodycolor').change(() => {
  var colorVal = $('#bodycolor').val()
  headColor(colors[colorVal], colorVal)
})

// Changing mouth colors
$('#mouthcolor').change(() => {
  var colorVal = $('#mouthcolor').val()
  mouthColor(colors[colorVal], colorVal)
})

// Changing eyes colors
$('#eyescolor').change(() => {
  var colorVal = $('#eyescolor').val()
  eyesColor(colors[colorVal], colorVal)
})

// Changing ears colors
$('#earscolor').change(() => {
  var colorVal = $('#earscolor').val()
  earsColor(colors[colorVal], colorVal)
})

// Changing eye shape
$('#eyeshape').change(() => {
  var shape = parseInt($('#eyeshape').val())
  eyeVariation(shape)
})

// Changing decoration shape
$('#decorationPattern').change(() => {
  var shape = parseInt($('#decorationPattern').val())
  decorationVariation(shape)
})

// Changing Mid Hair colors
$('#decorationMid').change(() => {
  var colorVal = $('#decorationMid').val()
  decorationMidcolor(colors[colorVal], colorVal)
})

// Changing Side Hair colors
$('#decorationSides').change(() => {
  var colorVal = $('#decorationSides').val()
  decorationSidescolor(colors[colorVal], colorVal)
})

// Animations
$('#animation').change(() => {
  var animationVal = parseInt($('#animation').val())
  animationVariation(animationVal)
})