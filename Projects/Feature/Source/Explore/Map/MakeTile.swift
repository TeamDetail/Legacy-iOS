import CoreLocation

struct LatLng {
    let lat: Double
    let lng: Double
}

struct Rectangle {
    let points: [LatLng] // 꼭짓점 4개 (시계방향)
}

let latPerPixel = 0.000724
let lonPerPixel = 0.000909

let strokeWidthToLat = 0.00000905
let strokeWidthToLng = 0.0000113625

let koreaTopLeftCorner = LatLng(lat: 43.00268544185012, lng: 124.27407423789127)

func makeRectangle(from coord: LatLng) -> Rectangle {
    let subX = floor((coord.lat - koreaTopLeftCorner.lat) / latPerPixel)
    let subY = floor((coord.lng - koreaTopLeftCorner.lng) / lonPerPixel)

    let sortedLat = koreaTopLeftCorner.lat + latPerPixel * subX
    let sortedLng = koreaTopLeftCorner.lng + lonPerPixel * subY

    return Rectangle(points: [
        LatLng(lat: sortedLat - strokeWidthToLat, lng: sortedLng + strokeWidthToLng),
        LatLng(lat: sortedLat - strokeWidthToLat, lng: sortedLng + lonPerPixel - strokeWidthToLng),
        LatLng(lat: sortedLat - latPerPixel + strokeWidthToLat, lng: sortedLng + lonPerPixel - strokeWidthToLng),
        LatLng(lat: sortedLat - latPerPixel + strokeWidthToLat, lng: sortedLng + strokeWidthToLng)
    ])
}
