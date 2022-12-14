/**
 * @license
 * Copyright 2019 Google LLC. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0
 */

// This example creates a 2-pixel-wide red polyline showing the path of
// the first trans-Pacific flight between Oakland, CA, and Brisbane,
// Australia which was made by Charles Kingsford Smith.

function initMap(): void {
  const map = new google.maps.Map(
    document.getElementById("map") as HTMLElement,
    {
      zoom: 3,
      center: { lat: 0, lng: -180 },
      mapTypeId: "terrain",
    }
  );

  // TODO: need to replace the hard coded Json value, fetch from IO file or MySQL database 
  const flightPlanCoordinates = [{"lat": 45.3470145, "lng": -75.7592736}, {"lat": 45.346976, "lng": -75.7594166}, {"lat": 45.3600194, "lng": -75.7676208}, {"lat": 45.41375499999999, "lng": -75.6793472}, {"lat": 45.41586230000001, "lng": -75.673887}, {"lat": 45.4249251, "lng": -75.6876139}, {"lat": 45.4261433, "lng": -75.6879305}, {"lat": 45.4251804, "lng": -75.6902019}];
  const flightPath = new google.maps.Polyline({
    path: flightPlanCoordinates,
    geodesic: true,
    strokeColor: "#FF0000",
    strokeOpacity: 1.0,
    strokeWeight: 2,
  });

  flightPath.setMap(map);
}

declare global {
  interface Window {
    initMap: () => void;
  }
}
window.initMap = initMap;
export {};
