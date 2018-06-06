/** @file
*
*  Udoo Neo Ultra Secured Digital Host Controllers (uSDHC)
*
*  Copyright (c) 2018 Microsoft Corporation. All rights reserved.
*
*  This program and the accompanying materials
*  are licensed and made available under the terms and conditions of the BSD License
*  which accompanies this distribution.  The full text of the license may be found at
*  http://opensource.org/licenses/bsd-license.php
*
*  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
*  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
*
**/

// uSDHC2: SDCard Socket
Device (SDH2)
{
  Name (_HID, "NXP0108")
  Name (_UID, 0x2)

  Method (_STA) {
    Return (0xf)
  }

  Name (_S1D, 0x1)
  Name (_S2D, 0x1)
  Name (_S3D, 0x1)
  Name (_S4D, 0x1)

  Name (_CRS, ResourceTemplate () {
    MEMORY32FIXED (ReadWrite, 0x02194000, 0x4000, )
    Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 55 }
  })

  // Child node to represent the only SD/MMC slot on this SD/MMC bus
  // In theory an SDHC can be connected to multiple SD/MMC slots at
  // the same time, but only 1 device will be selected and active at
  // a time
  Device (SD0) {
    Method (_ADR) {
      Return (0)
    }

    // Despite the SDCard is a removal device, UWF requires the
    // boot device to be non-removable. This is required for the
    // Windows SDCard boot scenario with UWF enabled.
    Method (_RMV) {
      Return (0)
    }
  }
}
