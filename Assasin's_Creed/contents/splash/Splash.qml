/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *   
 *   Modified by KJ 2021
 */

import QtQuick 2.5
import QtQuick.Window 2.2

Image {
    id: root
    source: "images/acmummy.jpg"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        
        Image {
            id: logo
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 32

            anchors.centerIn: parent

            source: "images/logo.png"

            sourceSize.width: size
            sourceSize.height: size
        }
     
        Image {
            id: busyIndicator
            y: parent.height - parent.height / 15 - height/15
            x: parent.width - parent.width / 64*63
            source: "images/busywidget.svgz"
            sourceSize.height: units.gridUnit * 3
            sourceSize.width: units.gridUnit * 3
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 1500
                loops: Animation.Infinite
            }
        } 
        
         Text {
                color: "#eff0f1"
                renderType: Screen.devicePixelRatio % 10 !== 1 ? Text.QtRendering : Text.NativeRendering
                y: parent.height - parent.height / 16 - height/16
                x: parent.width - parent.width / 64*60
                text: "Loading..."
            }
             
        Row {
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: units.gridUnit
            }
            
            Text {
                color: "#eff0f1"
                renderType: Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                text: "Splash made by KJ"
            }
            Image {
                source: "images/kali.png"
                sourceSize.height: units.gridUnit * 4
                sourceSize.width: units.gridUnit * 4
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
