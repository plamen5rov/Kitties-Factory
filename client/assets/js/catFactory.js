
//Random color
function getColor() {
    var randomColor = Math.floor(Math.random() * 16777215).toString(16);
    return randomColor
}

function genColors() {
    var colors = []
    for (var i = 10; i < 99; i++) {
        var color = getColor()
        colors[i] = color
    }
    return colors
}

//This function code needs to modified so that it works with Your cat code.
function headColor(color, code) {
    $('.cat__head, .cat__chest').css('background', '#' + color)  //This changes the color of the cat
    $('#headcode').html('code: ' + code) //This updates text of the badge next to the slider
    $('#dnabody').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function mouthColor(color, code) {
    $('.cat__mouth-contour, .cat__chest_inner, .cat__tail').css('background', '#' + color)  //This changes the color of the cat
    $('#mouthcode').html('code: ' + code) //This updates text of the badge next to the slider
    $('#dnamouth').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function eyesColor(color, code) {
    $('.cat__eye span').css('background', '#' + color)  //This changes the color of the cat
    $('#eyescode').html('code: ' + code) //This updates text of the badge next to the slider
    $('#dnaeyes').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function earsColor(color, code) {
    $('.cat__ear--left, .cat__ear--right, .cat__paw-left, .cat__paw-right, .cat__paw-left_inner, .cat__paw-right_inner').css('background', '#' + color)  //This changes the color of the cat
    $('#earscode').html('code: ' + code) //This updates text of the badge next to the slider
    $('#dnaears').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function decorationMidcolor(color, code) {
    $('.cat__head-dots').css('background', '#' + color)  //This changes the color of the cat
    $('#decorationMidCode').html('code: ' + code) //This updates text of the badge next to the slider
    $('#dnadecorationMid').html(code) //This updates the body color part of the DNA that is displayed below the cat
}

function decorationSidescolor(color, code) {
    $('.cat__head-dots_first, .cat__head-dots_second').css('background', '#' + color)  //This changes the color of the cat
    $('#decorationSidesCode').html('code: ' + code) //This updates text of the badge next to the slider
    $('#dnadecorationSides').html(code) //This updates the body color part of the DNA that is displayed below the cat
}
//###################################################
//Functions below will be used later on in the project
//###################################################
function eyeVariation(num) {

    $('#dnashape').html(num)
    switch (num) {
        case 1:
            normalEyes()
            $('#eyeName').html('Basic')
            break
        case 2:
            normalEyes()
            $('#eyeName').html('Chill')
            return eyesType1()
            break
        case 3:
            normalEyes()
            $('#eyeName').html('Shy')
            return eyesType2()
            break
        case 4:
            normalEyes()
            $('#eyeName').html('Left')
            return eyesType3()
            break
        case 5:
            normalEyes()
            $('#eyeName').html('Right')
            return eyesType4()
            break
        case 6:
            normalEyes()
            $('#eyeName').html('Sparky')
            return eyesType5()
            break
        case 7:
            normalEyes()
            $('#eyeName').html('Hypno')
            return eyesType6()
            break
    }
}

function normalEyes() {
    $('.cat__eye').find('span').css('border', 'none')
}

function eyesType1() {
    $('.cat__eye').find('span').css('border-top', '15px solid')
}

function eyesType2() {
    $('.cat__eye').find('span').css('border-bottom', '15px solid')
}

function eyesType3() {
    $('.cat__eye').find('span').css('border-left', '15px solid')
}

function eyesType4() {
    $('.cat__eye').find('span').css('border-right', '15px solid')
}

function eyesType5() {
    $('.cat__eye').find('span').css('border-top', '8px solid')
}

function eyesType6() {
    $('.cat__eye').find('span').css('border-bottom', '8px solid')
}


function decorationVariation(num) {
    $('#dnadecoration').html(num)
    switch (num) {
        case 1:
            $('#decorationName').html('Basic')
            normaldecoration()
            break
        case 2:
            $('#decorationName').html('15 deg')
            decoration2()
            break
        case 3:
            $('#decorationName').html('20 deg')
            decoration3()
            break
        case 4:
            $('#decorationName').html('25 deg')
            decoration4()
            break
        case 5:
            $('#decorationName').html('30 deg')
            decoration5()
            break
    }
}

// async function normalEyes() {
//     await $('.cat__eye').find('span').css('border', 'none')
// }

function normaldecoration() {
    //Remove all style from other decorations
    //In this way we can also use normalDecoration() to reset the decoration style
    $('.cat__head-dots').css({ "transform": "rotate(0deg)", "height": "48px", "width": "14px", "top": "1px", "border-radius": "0 0 50% 50%" })
    $('.cat__head-dots_first').css({ "transform": "rotate(0deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "50% 0 50% 50%" })
    $('.cat__head-dots_second').css({ "transform": "rotate(0deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "0 50% 50% 50%" })
}

function decoration2() {

    $('.cat__head-dots').css({ "transform": "rotate(15deg)", "height": "48px", "width": "14px", "top": "1px", "border-radius": "0 0 50% 50%" })
    $('.cat__head-dots_first').css({ "transform": "rotate(15deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "50% 0 50% 50%" })
    $('.cat__head-dots_second').css({ "transform": "rotate(15deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "0 50% 50% 50%" })
}

function decoration3() {

    $('.cat__head-dots').css({ "transform": "rotate(20deg)", "height": "48px", "width": "14px", "top": "1px", "border-radius": "0 0 50% 50%" })
    $('.cat__head-dots_first').css({ "transform": "rotate(20deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "50% 0 50% 50%" })
    $('.cat__head-dots_second').css({ "transform": "rotate(20deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "0 50% 50% 50%" })
}

function decoration4() {

    $('.cat__head-dots').css({ "transform": "rotate(25deg)", "height": "48px", "width": "14px", "top": "1px", "border-radius": "0 0 50% 50%" })
    $('.cat__head-dots_first').css({ "transform": "rotate(25deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "50% 0 50% 50%" })
    $('.cat__head-dots_second').css({ "transform": "rotate(25deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "0 50% 50% 50%" })
}

function decoration5() {

    $('.cat__head-dots').css({ "transform": "rotate(30deg)", "height": "48px", "width": "14px", "top": "1px", "border-radius": "0 0 50% 50%" })
    $('.cat__head-dots_first').css({ "transform": "rotate(30deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "50% 0 50% 50%" })
    $('.cat__head-dots_second').css({ "transform": "rotate(30deg)", "height": "35px", "width": "14px", "top": "1px", "border-radius": "0 50% 50% 50%" })
}

function animationVariation(num) {
    $('#dnaanimation').html(num)
    switch (num) {
        case 1:
            animation1()
            break
        case 2:
            animation2()
            break
        case 3:
            animation3()
            break
        case 4:
            animation4()
            break
    }
}

function animation1() {
    $('#animationCode').html('None')
    $('#head').removeClass('movingHead')
    $('#.cat__ear').removeClass('movingHead')

}

function animation2() {
    $('#head').addClass('movingHead')
    $('#animationCode').html('Head')

}

function animation3() {
    $('#head').removeClass('movingHead')
    $('.cat__ear').addClass('movingHead')
    $('#animationCode').html('Ears')

}

function animation4() {
    $('#head').addClass('movingHead')
    $('.cat__ear').addClass('movingHead')
    $('#animationCode').html('Head & ears')

}
