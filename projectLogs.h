//
//  Header.h
//  GoldenScissors
//
//  Created by EventHorizon on 20/01/2015.
//  Copyright (c) 2015 EventHorizon. All rights reserved.
//

#ifndef GoldenScissors_Header_h
#define GoldenScissors_Header_h

/*
 
 //here i was testing the removal and addition of customers to DB - and its affect on dropbox upload.
 
 15-01-20 17:05:26.936 GoldenScissors[6014:1973165] filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:05:36.330 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:05:36
 2015-01-20 17:05:36.332 GoldenScissors[6014:1973165] ** UNIQUE DROPBOX FILENAME ** = debugNewFile2015-01-20-05:05:36.txt
 2015-01-20 17:05:36.356 GoldenScissors[6014:1973165] Success when creating file in Dropbox filesystem
 2015-01-20 17:05:36.358 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:05:36.362 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:05:36
 2015-01-20 17:05:36.364 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:05:36.365 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:05:36.txt<-
 2015-01-20 17:05:36.367 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:05:36.377 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:05:36
 2015-01-20 17:05:36.378 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:05:36.379 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:05:36.txt<-
 2015-01-20 17:05:36.382 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:05:36.385 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:05:36
 2015-01-20 17:05:36.386 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:05:36.388 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:05:36.txt<-
 2015-01-20 17:05:36.392 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:05:36.394 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:05:36
 2015-01-20 17:05:36.395 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:05:36.397 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:05:36.txt<-
 2015-01-20 17:05:36.399 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:05:36.401 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:05:36
 2015-01-20 17:05:36.402 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:05:36.403 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:05:36.txt<-
 2015-01-20 17:05:36.407 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:05:36.410 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:05:36
 2015-01-20 17:05:36.412 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:05:36.413 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:05:36.txt<-
 2015-01-20 17:05:36.424 GoldenScissors[6014:1973165] Successfully wrote to file /debugNewFile2015-01-20-05:05:36.txt on dropbox
 2015-01-20 17:06:38.592 GoldenScissors[6014:1973165] processing select statement correctly  :)-- SQL string = DELETE FROM CustomerCard where code = "7531"
 2015-01-20 17:08:12.060 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:08:12
 2015-01-20 17:08:12.061 GoldenScissors[6014:1973165] ** UNIQUE DROPBOX FILENAME ** = debugNewFile2015-01-20-05:08:12.txt
 2015-01-20 17:08:12.102 GoldenScissors[6014:1973165] Success when creating file in Dropbox filesystem
 2015-01-20 17:08:12.103 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:08:12.108 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:08:12
 2015-01-20 17:08:12.109 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:08:12.110 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:08:12.txt<-
 2015-01-20 17:08:12.112 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:08:12.116 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:08:12
 2015-01-20 17:08:12.116 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:08:12.117 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:08:12.txt<-
 2015-01-20 17:08:12.120 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:08:12.128 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:08:12
 2015-01-20 17:08:12.130 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:08:12.132 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:08:12.txt<-
 2015-01-20 17:08:12.133 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:08:12.135 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:08:12
 2015-01-20 17:08:12.136 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:08:12.137 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:08:12.txt<-
 2015-01-20 17:08:12.138 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:08:12.141 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:08:12
 2015-01-20 17:08:12.142 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:08:12.142 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:08:12.txt<-
 2015-01-20 17:08:12.144 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:08:12.146 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:08:12
 2015-01-20 17:08:12.147 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:08:12.147 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:08:12.txt<-
 2015-01-20 17:08:12.148 GoldenScissors[6014:1973165] at date attempt !
 2015-01-20 17:08:12.151 GoldenScissors[6014:1973165] currDate = 2015-01-20-05:08:12
 2015-01-20 17:08:12.151 GoldenScissors[6014:1973165] back up filePath = (
 "/var/mobile/Containers/Data/Application/953B3C99-D795-4560-9A3E-D0328473B486/Documents"
 )
 2015-01-20 17:08:12.152 GoldenScissors[6014:1973165] and file name located here is = ->backUp2015-01-20-05:08:12.txt<-
 2015-01-20 17:08:12.163 GoldenScissors[6014:1973165] Successfully wrote to file /debugNewFile2015-01-20-05:08:12.txt on dropbox

 
*/

#endif
