SELECT Id
FROM
(
	SELECT Account__c, Id, Name, ROW_NUMBER () OVER (PARTITION BY Account__c ORDER BY CreatedDate) rn
	FROM Salesforce..Site__c
	WHERE LEFT(Account__c, 15) collate latin1_general_CS_AS in
	(
	'001D000002BKote',
	'001D0000025d0c1',
	'001D00000223PFo',
	'001D000002BWS27',
	'001D000002Bp53p',
	'001D000002A3x96',
	'001D000001rqfWO',
	'001D00000256OXO',
	'001D0000024Ypxw',
	'001D00000279UEk',
	'001D000002AgEu0',
	'001D000002BoqrB',
	'001D000002Ag6Tp',
	'001D000002Bwxjo',
	'001D000002DpHKw',
	'001D000001HcsQS',
	'001D000002BKPxK',
	'001D000002BpOhj',
	'001D000002BKNS4',
	'001D000002Aglh4',
	'001D000001Rj4cM',
	'001D000002ERjSo',
	'001D00000279lwo',
	'001D000001u7csw',
	'001D000002EOet9',
	'001D0000027QnM6',
	'001D000001u5cmW',
	'001D000002BJuuo',
	'001D000001xRDWF',
	'001D000001e3edx',
	'001D000002AiJvH',
	'001D000001v0Nso',
	'001D000001mxNs3',
	'001D000001ydLUv',
	'001D000001mvkZG',
	'001D000001uXIqK',
	'001D000002BtlFQ',
	'001D000001W4McC',
	'001D000002BHtL1',
	'001D000001vjYNC',
	'001D000001qhbW4',
	'001D000002A61xl',
	'001D000001hpWoH',
	'001D000002AgmUU',
	'001D000001r3etK',
	'001D000002BtuwT',
	'001D000002AgEf0',
	'001D000001tgsmn',
	'001D000001HctgB',
	'00TD000005ETFj8',
	'001D000001ycsmX',
	'001D000001ltBrB',
	'001D000001e3Ifw',
	'001D000001mwxIi',
	'001D000001rqf2b',
	'001D000001Hctec',
	'001D000001HctGO',
	'001D000001HcsWA',
	'001D000001skW5Y',
	'001D000001Hcs1u',
	'001D000001lpiJf',
	'001D000001wd0lj',
	'001D000001idbZi',
	'001D000002A4k4T',
	'001D000001e3Y69',
	'001D000001bbCUW',
	'001D0000026TBx1',
	'001D000001Hct9O',
	'001D000002Btg74',
	'001D000002BwHhR',
	'001D000001Hcs5w',
	'001D000002AiUzY',
	'001D0000024Ynia',
	'001D0000020KkDW',
	'001D000001viVAL',
	'001D000001HctTD',
	'001D000001mvuzb',
	'001D000002DoIqI',
	'001D000002AjepC',
	'001D000002FL4L8',
	'001D000001wbYTH',
	'001D000001rqfHa',
	'001D000002BJ8Jk',
	'001D000001F8ThJ',
	'001D000002BKdUw',
	'001D000002A7YT0',
	'001D0000029eQHZ',
	'001D000002Bp82Q',
	'001D000001wrnLe',
	'001D000002Bv6EI',
	'001D000001yEYoI',
	'001D000002BKooo',
	'001D000002BXgfe',
	'001D000002BLFP1',
	'001D000002465De',
	'001D000002Bor5r',
	'001D000002A5Uac',
	'001D000002Ah06s',
	'001D000001Hct79',
	'001D000001u865v',
	'001D00000257Iz0',
	'001D000002CzXGO',
	'001D000001HctBy',
	'001D000002AjPvj',
	'001D000002AhTMt',
	'001D000002Bw7qz',
	'001D000001t67Ld',
	'001D000002AjPwD',
	'001D000002A4XXi',
	'001D000001uUpqI',
	'001D000002BWQBi',
	'001D000001tI793',
	'001D000001u5WVC',
	'001D000002BtjtP',
	'001D000001xS5Sr',
	'001D000001YtJdx',
	'001D000001e36C4',
	'001D000001HctPx',
	'001D0000027QnUe',
	'001D000002AglbB',
	'001D000001z1yUw',
	'001D000002CB84j',
	'001D0000025dHAy',
	'001D000002BIgfh',
	'001D000001HcsbJ',
	'001D000002A4jXo',
	'001D000002AiT6I',
	'001D000002BIQ3U',
	'001D000002Dofmd',
	'001D0000022358v',
	'001D000001HcsEW',
	'001D000001Hcsl6',
	'001D000002A6KoM',
	'001D000001wtBsl',
	'001D000001rqh6E',
	'001D000002BtAYM',
	'001D000001HctDz',
	'001D00000254hEd',
	'001D0000029eRmv',
	'001D0000020gl9B',
	'001D000002BpQpn',
	'001D000001lsoXs',
	'001D000001Hcs2g',
	'001D000001xmNPm',
	'001D0000025eubd'
	)
) detail
WHERE rn > 1