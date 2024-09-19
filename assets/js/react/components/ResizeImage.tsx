export function resizeImage(image: any, maxWidth: any, maxHeight: any) {
    let scale = 1
    let width = image.naturalWidth
    let height = image.naturalHeight

    if (width > maxWidth) {
        scale = image.width / maxWidth
        width = maxWidth
        height = image.height / scale
    }

    if (height > maxHeight) {
        scale = image.height / maxHeight
        height = maxHeight
        width = image.width / scale
    }

    width = Math.floor(width)
    height = Math.floor(height)

    const canvas = document.createElement("canvas")
    canvas.width = width
    canvas.height = height

    let context2D: any = canvas.getContext("2d")
    context2D.drawImage(image, 0, 0, width, height)

    return canvas.toDataURL();
}