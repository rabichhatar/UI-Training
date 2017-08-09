function download(strData, strFileName, strMimeType) {

    var a = document.createElement("a");

    strMimeType = strMimeType || "application/octet-stream";



    if (navigator.msSaveBlob) { // IE10+

        return navigator.msSaveBlob(new Blob([strData], { type: strMimeType }), strFileName);

    } /* end if(navigator.msSaveBlob) */





    if ('download' in a) { //html5 A[download]

        a.href = "data:" + strMimeType + "," + encodeURIComponent(strData);

        a.setAttribute("download", strFileName);

        a.innerHTML = "downloading...";

        document.body.appendChild(a);

        setTimeout(function () {

            a.click();

            document.body.removeChild(a);

        }, 66);

        return true;

    } /* end if('download' in a) */





    //do iframe dataURL download (old ch+FF):

    var f = document.createElement("iframe");

    document.body.appendChild(f);

    f.src = "data:" + strMimeType + "," + encodeURIComponent(strData);



    setTimeout(function () {

        document.body.removeChild(f);

    }, 333);

    return true;

} /* end download() */