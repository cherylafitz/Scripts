#This program looks in the working directory, and renames all available PDF files according to a list of filenames provided in filenames.txt.  It's designed to work with the output of Acrobat PDFMaker 10.1 for Word, and can handle up to 1000 files.

use warnings;
use strict;
use 5.010;

#Declare variables
my @filenames;
my @PDFs = glob '*.pdf'; # assign all pdf files to an array, arranged alphabetically
my @numbered;
my $inputfile = "filenames.txt";
my @irregular;
my @short;

#This hash stores the numbers that PDFMaker attaches to created PDFs, and keys them to a simpler sorting number.
my %deobfuscated = (
	'1501' => '0001',
	'1502' => '0002',
	'1503' => '0003',
	'1504' => '0004',
	'1505' => '0005',
	'1506' => '0006',
	'1507' => '0007',
	'1508' => '0008',
	'1509' => '0009',
	'15010' => '0010',
	'15011' => '0011',
	'15012' => '0012',
	'15013' => '0013',
	'15014' => '0014',
	'15015' => '0015',
	'15016' => '0016',
	'15017' => '0017',
	'15018' => '0018',
	'15019' => '0019',
	'15020' => '0020',
	'15021' => '0021',
	'15022' => '0022',
	'15023' => '0023',
	'15024' => '0024',
	'15025' => '0025',
	'15026' => '0026',
	'15027' => '0027',
	'15028' => '0028',
	'15029' => '0029',
	'15030' => '0030',
	'15031' => '0031',
	'15032' => '0032',
	'15033' => '0033',
	'15034' => '0034',
	'15035' => '0035',
	'15036' => '0036',
	'15037' => '0037',
	'15038' => '0038',
	'15039' => '0039',
	'15040' => '0040',
	'15041' => '0041',
	'15042' => '0042',
	'15043' => '0043',
	'15044' => '0044',
	'15045' => '0045',
	'15046' => '0046',
	'15047' => '0047',
	'15048' => '0048',
	'15049' => '0049',
	'15050' => '0050',
	'511001' => '0051',
	'511002' => '0052',
	'511003' => '0053',
	'511004' => '0054',
	'511005' => '0055',
	'511006' => '0056',
	'511007' => '0057',
	'511008' => '0058',
	'511009' => '0059',
	'5110010' => '0060',
	'5110011' => '0061',
	'5110012' => '0062',
	'5110013' => '0063',
	'5110014' => '0064',
	'5110015' => '0065',
	'5110016' => '0066',
	'5110017' => '0067',
	'5110018' => '0068',
	'5110019' => '0069',
	'5110020' => '0070',
	'5110021' => '0071',
	'5110022' => '0072',
	'5110023' => '0073',
	'5110024' => '0074',
	'5110025' => '0075',
	'5110026' => '0076',
	'5110027' => '0077',
	'5110028' => '0078',
	'5110029' => '0079',
	'5110030' => '0080',
	'5110031' => '0081',
	'5110032' => '0082',
	'5110033' => '0083',
	'5110034' => '0084',
	'5110035' => '0085',
	'5110036' => '0086',
	'5110037' => '0087',
	'5110038' => '0088',
	'5110039' => '0089',
	'5110040' => '0090',
	'5110041' => '0091',
	'5110042' => '0092',
	'5110043' => '0093',
	'5110044' => '0094',
	'5110045' => '0095',
	'5110046' => '0096',
	'5110047' => '0097',
	'5110048' => '0098',
	'5110049' => '0099',
	'5110050' => '0100',
	'1011501' => '0101',
	'1011502' => '0102',
	'1011503' => '0103',
	'1011504' => '0104',
	'1011505' => '0105',
	'1011506' => '0106',
	'1011507' => '0107',
	'1011508' => '0108',
	'1011509' => '0109',
	'10115010' => '0110',
	'10115011' => '0111',
	'10115012' => '0112',
	'10115013' => '0113',
	'10115014' => '0114',
	'10115015' => '0115',
	'10115016' => '0116',
	'10115017' => '0117',
	'10115018' => '0118',
	'10115019' => '0119',
	'10115020' => '0120',
	'10115021' => '0121',
	'10115022' => '0122',
	'10115023' => '0123',
	'10115024' => '0124',
	'10115025' => '0125',
	'10115026' => '0126',
	'10115027' => '0127',
	'10115028' => '0128',
	'10115029' => '0129',
	'10115030' => '0130',
	'10115031' => '0131',
	'10115032' => '0132',
	'10115033' => '0133',
	'10115034' => '0134',
	'10115035' => '0135',
	'10115036' => '0136',
	'10115037' => '0137',
	'10115038' => '0138',
	'10115039' => '0139',
	'10115040' => '0140',
	'10115041' => '0141',
	'10115042' => '0142',
	'10115043' => '0143',
	'10115044' => '0144',
	'10115045' => '0145',
	'10115046' => '0146',
	'10115047' => '0147',
	'10115048' => '0148',
	'10115049' => '0149',
	'10115050' => '0150',
	'1512001' => '0151',
	'1512002' => '0152',
	'1512003' => '0153',
	'1512004' => '0154',
	'1512005' => '0155',
	'1512006' => '0156',
	'1512007' => '0157',
	'1512008' => '0158',
	'1512009' => '0159',
	'15120010' => '0160',
	'15120011' => '0161',
	'15120012' => '0162',
	'15120013' => '0163',
	'15120014' => '0164',
	'15120015' => '0165',
	'15120016' => '0166',
	'15120017' => '0167',
	'15120018' => '0168',
	'15120019' => '0169',
	'15120020' => '0170',
	'15120021' => '0171',
	'15120022' => '0172',
	'15120023' => '0173',
	'15120024' => '0174',
	'15120025' => '0175',
	'15120026' => '0176',
	'15120027' => '0177',
	'15120028' => '0178',
	'15120029' => '0179',
	'15120030' => '0180',
	'15120031' => '0181',
	'15120032' => '0182',
	'15120033' => '0183',
	'15120034' => '0184',
	'15120035' => '0185',
	'15120036' => '0186',
	'15120037' => '0187',
	'15120038' => '0188',
	'15120039' => '0189',
	'15120040' => '0190',
	'15120041' => '0191',
	'15120042' => '0192',
	'15120043' => '0193',
	'15120044' => '0194',
	'15120045' => '0195',
	'15120046' => '0196',
	'15120047' => '0197',
	'15120048' => '0198',
	'15120049' => '0199',
	'15120050' => '0200',
	'2012501' => '0201',
	'2012502' => '0202',
	'2012503' => '0203',
	'2012504' => '0204',
	'2012505' => '0205',
	'2012506' => '0206',
	'2012507' => '0207',
	'2012508' => '0208',
	'2012509' => '0209',
	'20125010' => '0210',
	'20125011' => '0211',
	'20125012' => '0212',
	'20125013' => '0213',
	'20125014' => '0214',
	'20125015' => '0215',
	'20125016' => '0216',
	'20125017' => '0217',
	'20125018' => '0218',
	'20125019' => '0219',
	'20125020' => '0220',
	'20125021' => '0221',
	'20125022' => '0222',
	'20125023' => '0223',
	'20125024' => '0224',
	'20125025' => '0225',
	'20125026' => '0226',
	'20125027' => '0227',
	'20125028' => '0228',
	'20125029' => '0229',
	'20125030' => '0230',
	'20125031' => '0231',
	'20125032' => '0232',
	'20125033' => '0233',
	'20125034' => '0234',
	'20125035' => '0235',
	'20125036' => '0236',
	'20125037' => '0237',
	'20125038' => '0238',
	'20125039' => '0239',
	'20125040' => '0240',
	'20125041' => '0241',
	'20125042' => '0242',
	'20125043' => '0243',
	'20125044' => '0244',
	'20125045' => '0245',
	'20125046' => '0246',
	'20125047' => '0247',
	'20125048' => '0248',
	'20125049' => '0249',
	'20125050' => '0250',
	'2513001' => '0251',
	'2513002' => '0252',
	'2513003' => '0253',
	'2513004' => '0254',
	'2513005' => '0255',
	'2513006' => '0256',
	'2513007' => '0257',
	'2513008' => '0258',
	'2513009' => '0259',
	'25130010' => '0260',
	'25130011' => '0261',
	'25130012' => '0262',
	'25130013' => '0263',
	'25130014' => '0264',
	'25130015' => '0265',
	'25130016' => '0266',
	'25130017' => '0267',
	'25130018' => '0268',
	'25130019' => '0269',
	'25130020' => '0270',
	'25130021' => '0271',
	'25130022' => '0272',
	'25130023' => '0273',
	'25130024' => '0274',
	'25130025' => '0275',
	'25130026' => '0276',
	'25130027' => '0277',
	'25130028' => '0278',
	'25130029' => '0279',
	'25130030' => '0280',
	'25130031' => '0281',
	'25130032' => '0282',
	'25130033' => '0283',
	'25130034' => '0284',
	'25130035' => '0285',
	'25130036' => '0286',
	'25130037' => '0287',
	'25130038' => '0288',
	'25130039' => '0289',
	'25130040' => '0290',
	'25130041' => '0291',
	'25130042' => '0292',
	'25130043' => '0293',
	'25130044' => '0294',
	'25130045' => '0295',
	'25130046' => '0296',
	'25130047' => '0297',
	'25130048' => '0298',
	'25130049' => '0299',
	'25130050' => '0300',
	'3013501' => '0301',
	'3013502' => '0302',
	'3013503' => '0303',
	'3013504' => '0304',
	'3013505' => '0305',
	'3013506' => '0306',
	'3013507' => '0307',
	'3013508' => '0308',
	'3013509' => '0309',
	'30135010' => '0310',
	'30135011' => '0311',
	'30135012' => '0312',
	'30135013' => '0313',
	'30135014' => '0314',
	'30135015' => '0315',
	'30135016' => '0316',
	'30135017' => '0317',
	'30135018' => '0318',
	'30135019' => '0319',
	'30135020' => '0320',
	'30135021' => '0321',
	'30135022' => '0322',
	'30135023' => '0323',
	'30135024' => '0324',
	'30135025' => '0325',
	'30135026' => '0326',
	'30135027' => '0327',
	'30135028' => '0328',
	'30135029' => '0329',
	'30135030' => '0330',
	'30135031' => '0331',
	'30135032' => '0332',
	'30135033' => '0333',
	'30135034' => '0334',
	'30135035' => '0335',
	'30135036' => '0336',
	'30135037' => '0337',
	'30135038' => '0338',
	'30135039' => '0339',
	'30135040' => '0340',
	'30135041' => '0341',
	'30135042' => '0342',
	'30135043' => '0343',
	'30135044' => '0344',
	'30135045' => '0345',
	'30135046' => '0346',
	'30135047' => '0347',
	'30135048' => '0348',
	'30135049' => '0349',
	'30135050' => '0350',
	'3514001' => '0351',
	'3514002' => '0352',
	'3514003' => '0353',
	'3514004' => '0354',
	'3514005' => '0355',
	'3514006' => '0356',
	'3514007' => '0357',
	'3514008' => '0358',
	'3514009' => '0359',
	'35140010' => '0360',
	'35140011' => '0361',
	'35140012' => '0362',
	'35140013' => '0363',
	'35140014' => '0364',
	'35140015' => '0365',
	'35140016' => '0366',
	'35140017' => '0367',
	'35140018' => '0368',
	'35140019' => '0369',
	'35140020' => '0370',
	'35140021' => '0371',
	'35140022' => '0372',
	'35140023' => '0373',
	'35140024' => '0374',
	'35140025' => '0375',
	'35140026' => '0376',
	'35140027' => '0377',
	'35140028' => '0378',
	'35140029' => '0379',
	'35140030' => '0380',
	'35140031' => '0381',
	'35140032' => '0382',
	'35140033' => '0383',
	'35140034' => '0384',
	'35140035' => '0385',
	'35140036' => '0386',
	'35140037' => '0387',
	'35140038' => '0388',
	'35140039' => '0389',
	'35140040' => '0390',
	'35140041' => '0391',
	'35140042' => '0392',
	'35140043' => '0393',
	'35140044' => '0394',
	'35140045' => '0395',
	'35140046' => '0396',
	'35140047' => '0397',
	'35140048' => '0398',
	'35140049' => '0399',
	'35140050' => '0400',
	'4014501' => '0401',
	'4014502' => '0402',
	'4014503' => '0403',
	'4014504' => '0404',
	'4014505' => '0405',
	'4014506' => '0406',
	'4014507' => '0407',
	'4014508' => '0408',
	'4014509' => '0409',
	'40145010' => '0410',
	'40145011' => '0411',
	'40145012' => '0412',
	'40145013' => '0413',
	'40145014' => '0414',
	'40145015' => '0415',
	'40145016' => '0416',
	'40145017' => '0417',
	'40145018' => '0418',
	'40145019' => '0419',
	'40145020' => '0420',
	'40145021' => '0421',
	'40145022' => '0422',
	'40145023' => '0423',
	'40145024' => '0424',
	'40145025' => '0425',
	'40145026' => '0426',
	'40145027' => '0427',
	'40145028' => '0428',
	'40145029' => '0429',
	'40145030' => '0430',
	'40145031' => '0431',
	'40145032' => '0432',
	'40145033' => '0433',
	'40145034' => '0434',
	'40145035' => '0435',
	'40145036' => '0436',
	'40145037' => '0437',
	'40145038' => '0438',
	'40145039' => '0439',
	'40145040' => '0440',
	'40145041' => '0441',
	'40145042' => '0442',
	'40145043' => '0443',
	'40145044' => '0444',
	'40145045' => '0445',
	'40145046' => '0446',
	'40145047' => '0447',
	'40145048' => '0448',
	'40145049' => '0449',
	'40145050' => '0450',
	'4515001' => '0451',
	'4515002' => '0452',
	'4515003' => '0453',
	'4515004' => '0454',
	'4515005' => '0455',
	'4515006' => '0456',
	'4515007' => '0457',
	'4515008' => '0458',
	'4515009' => '0459',
	'45150010' => '0460',
	'45150011' => '0461',
	'45150012' => '0462',
	'45150013' => '0463',
	'45150014' => '0464',
	'45150015' => '0465',
	'45150016' => '0466',
	'45150017' => '0467',
	'45150018' => '0468',
	'45150019' => '0469',
	'45150020' => '0470',
	'45150021' => '0471',
	'45150022' => '0472',
	'45150023' => '0473',
	'45150024' => '0474',
	'45150025' => '0475',
	'45150026' => '0476',
	'45150027' => '0477',
	'45150028' => '0478',
	'45150029' => '0479',
	'45150030' => '0480',
	'45150031' => '0481',
	'45150032' => '0482',
	'45150033' => '0483',
	'45150034' => '0484',
	'45150035' => '0485',
	'45150036' => '0486',
	'45150037' => '0487',
	'45150038' => '0488',
	'45150039' => '0489',
	'45150040' => '0490',
	'45150041' => '0491',
	'45150042' => '0492',
	'45150043' => '0493',
	'45150044' => '0494',
	'45150045' => '0495',
	'45150046' => '0496',
	'45150047' => '0497',
	'45150048' => '0498',
	'45150049' => '0499',
	'45150050' => '0500',
	'5015501' => '0501',
	'5015502' => '0502',
	'5015503' => '0503',
	'5015504' => '0504',
	'5015505' => '0505',
	'5015506' => '0506',
	'5015507' => '0507',
	'5015508' => '0508',
	'5015509' => '0509',
	'50155010' => '0510',
	'50155011' => '0511',
	'50155012' => '0512',
	'50155013' => '0513',
	'50155014' => '0514',
	'50155015' => '0515',
	'50155016' => '0516',
	'50155017' => '0517',
	'50155018' => '0518',
	'50155019' => '0519',
	'50155020' => '0520',
	'50155021' => '0521',
	'50155022' => '0522',
	'50155023' => '0523',
	'50155024' => '0524',
	'50155025' => '0525',
	'50155026' => '0526',
	'50155027' => '0527',
	'50155028' => '0528',
	'50155029' => '0529',
	'50155030' => '0530',
	'50155031' => '0531',
	'50155032' => '0532',
	'50155033' => '0533',
	'50155034' => '0534',
	'50155035' => '0535',
	'50155036' => '0536',
	'50155037' => '0537',
	'50155038' => '0538',
	'50155039' => '0539',
	'50155040' => '0540',
	'50155041' => '0541',
	'50155042' => '0542',
	'50155043' => '0543',
	'50155044' => '0544',
	'50155045' => '0545',
	'50155046' => '0546',
	'50155047' => '0547',
	'50155048' => '0548',
	'50155049' => '0549',
	'50155050' => '0550',
	'5516001' => '0551',
	'5516002' => '0552',
	'5516003' => '0553',
	'5516004' => '0554',
	'5516005' => '0555',
	'5516006' => '0556',
	'5516007' => '0557',
	'5516008' => '0558',
	'5516009' => '0559',
	'55160010' => '0560',
	'55160011' => '0561',
	'55160012' => '0562',
	'55160013' => '0563',
	'55160014' => '0564',
	'55160015' => '0565',
	'55160016' => '0566',
	'55160017' => '0567',
	'55160018' => '0568',
	'55160019' => '0569',
	'55160020' => '0570',
	'55160021' => '0571',
	'55160022' => '0572',
	'55160023' => '0573',
	'55160024' => '0574',
	'55160025' => '0575',
	'55160026' => '0576',
	'55160027' => '0577',
	'55160028' => '0578',
	'55160029' => '0579',
	'55160030' => '0580',
	'55160031' => '0581',
	'55160032' => '0582',
	'55160033' => '0583',
	'55160034' => '0584',
	'55160035' => '0585',
	'55160036' => '0586',
	'55160037' => '0587',
	'55160038' => '0588',
	'55160039' => '0589',
	'55160040' => '0590',
	'55160041' => '0591',
	'55160042' => '0592',
	'55160043' => '0593',
	'55160044' => '0594',
	'55160045' => '0595',
	'55160046' => '0596',
	'55160047' => '0597',
	'55160048' => '0598',
	'55160049' => '0599',
	'55160050' => '0600',
	'6016501' => '0601',
	'6016502' => '0602',
	'6016503' => '0603',
	'6016504' => '0604',
	'6016505' => '0605',
	'6016506' => '0606',
	'6016507' => '0607',
	'6016508' => '0608',
	'6016509' => '0609',
	'60165010' => '0610',
	'60165011' => '0611',
	'60165012' => '0612',
	'60165013' => '0613',
	'60165014' => '0614',
	'60165015' => '0615',
	'60165016' => '0616',
	'60165017' => '0617',
	'60165018' => '0618',
	'60165019' => '0619',
	'60165020' => '0620',
	'60165021' => '0621',
	'60165022' => '0622',
	'60165023' => '0623',
	'60165024' => '0624',
	'60165025' => '0625',
	'60165026' => '0626',
	'60165027' => '0627',
	'60165028' => '0628',
	'60165029' => '0629',
	'60165030' => '0630',
	'60165031' => '0631',
	'60165032' => '0632',
	'60165033' => '0633',
	'60165034' => '0634',
	'60165035' => '0635',
	'60165036' => '0636',
	'60165037' => '0637',
	'60165038' => '0638',
	'60165039' => '0639',
	'60165040' => '0640',
	'60165041' => '0641',
	'60165042' => '0642',
	'60165043' => '0643',
	'60165044' => '0644',
	'60165045' => '0645',
	'60165046' => '0646',
	'60165047' => '0647',
	'60165048' => '0648',
	'60165049' => '0649',
	'65170050' => '0650',
	'6517001' => '0651',
	'6517002' => '0652',
	'6517003' => '0653',
	'6517004' => '0654',
	'6517005' => '0655',
	'6517006' => '0656',
	'6517007' => '0657',
	'6517008' => '0658',
	'6517009' => '0659',
	'65170010' => '0660',
	'65170011' => '0661',
	'65170012' => '0662',
	'65170013' => '0663',
	'65170014' => '0664',
	'65170015' => '0665',
	'65170016' => '0666',
	'65170017' => '0667',
	'65170018' => '0668',
	'65170019' => '0669',
	'65170020' => '0670',
	'65170021' => '0671',
	'65170022' => '0672',
	'65170023' => '0673',
	'65170024' => '0674',
	'65170025' => '0675',
	'65170026' => '0676',
	'65170027' => '0677',
	'65170028' => '0678',
	'65170029' => '0679',
	'65170030' => '0680',
	'65170031' => '0681',
	'65170032' => '0682',
	'65170033' => '0683',
	'65170034' => '0684',
	'65170035' => '0685',
	'65170036' => '0686',
	'65170037' => '0687',
	'65170038' => '0688',
	'65170039' => '0689',
	'65170040' => '0690',
	'65170041' => '0691',
	'65170042' => '0692',
	'65170043' => '0693',
	'65170044' => '0694',
	'65170045' => '0695',
	'65170046' => '0696',
	'65170047' => '0697',
	'65170048' => '0698',
	'65170049' => '0699',
	'65170050' => '0700',
	'7017501' => '0701',
	'7017502' => '0702',
	'7017503' => '0703',
	'7017504' => '0704',
	'7017505' => '0705',
	'7017506' => '0706',
	'7017507' => '0707',
	'7017508' => '0708',
	'7017509' => '0709',
	'70175010' => '0710',
	'70175011' => '0711',
	'70175012' => '0712',
	'70175013' => '0713',
	'70175014' => '0714',
	'70175015' => '0715',
	'70175016' => '0716',
	'70175017' => '0717',
	'70175018' => '0718',
	'70175019' => '0719',
	'70175020' => '0720',
	'70175021' => '0721',
	'70175022' => '0722',
	'70175023' => '0723',
	'70175024' => '0724',
	'70175025' => '0725',
	'70175026' => '0726',
	'70175027' => '0727',
	'70175028' => '0728',
	'70175029' => '0729',
	'70175030' => '0730',
	'70175031' => '0731',
	'70175032' => '0732',
	'70175033' => '0733',
	'70175034' => '0734',
	'70175035' => '0735',
	'70175036' => '0736',
	'70175037' => '0737',
	'70175038' => '0738',
	'70175039' => '0739',
	'70175040' => '0740',
	'70175041' => '0741',
	'70175042' => '0742',
	'70175043' => '0743',
	'70175044' => '0744',
	'70175045' => '0745',
	'70175046' => '0746',
	'70175047' => '0747',
	'70175048' => '0748',
	'70175049' => '0749',
	'70175050' => '0750',
	'7518001' => '0751',
	'7518002' => '0752',
	'7518003' => '0753',
	'7518004' => '0754',
	'7518005' => '0755',
	'7518006' => '0756',
	'7518007' => '0757',
	'7518008' => '0758',
	'7518009' => '0759',
	'75180010' => '0760',
	'75180011' => '0761',
	'75180012' => '0762',
	'75180013' => '0763',
	'75180014' => '0764',
	'75180015' => '0765',
	'75180016' => '0766',
	'75180017' => '0767',
	'75180018' => '0768',
	'75180019' => '0769',
	'75180020' => '0770',
	'75180021' => '0771',
	'75180022' => '0772',
	'75180023' => '0773',
	'75180024' => '0774',
	'75180025' => '0775',
	'75180026' => '0776',
	'75180027' => '0777',
	'75180028' => '0778',
	'75180029' => '0779',
	'75180030' => '0780',
	'75180031' => '0781',
	'75180032' => '0782',
	'75180033' => '0783',
	'75180034' => '0784',
	'75180035' => '0785',
	'75180036' => '0786',
	'75180037' => '0787',
	'75180038' => '0788',
	'75180039' => '0789',
	'75180040' => '0790',
	'75180041' => '0791',
	'75180042' => '0792',
	'75180043' => '0793',
	'75180044' => '0794',
	'75180045' => '0795',
	'75180046' => '0796',
	'75180047' => '0797',
	'75180048' => '0798',
	'75180049' => '0799',
	'75180050' => '0800',
	'8018501' => '0801',
	'8018502' => '0802',
	'8018503' => '0803',
	'8018504' => '0804',
	'8018505' => '0805',
	'8018506' => '0806',
	'8018507' => '0807',
	'8018508' => '0808',
	'8018509' => '0809',
	'80185010' => '0810',
	'80185011' => '0811',
	'80185012' => '0812',
	'80185013' => '0813',
	'80185014' => '0814',
	'80185015' => '0815',
	'80185016' => '0816',
	'80185017' => '0817',
	'80185018' => '0818',
	'80185019' => '0819',
	'80185020' => '0820',
	'80185021' => '0821',
	'80185022' => '0822',
	'80185023' => '0823',
	'80185024' => '0824',
	'80185025' => '0825',
	'80185026' => '0826',
	'80185027' => '0827',
	'80185028' => '0828',
	'80185029' => '0829',
	'80185030' => '0830',
	'80185031' => '0831',
	'80185032' => '0832',
	'80185033' => '0833',
	'80185034' => '0834',
	'80185035' => '0835',
	'80185036' => '0836',
	'80185037' => '0837',
	'80185038' => '0838',
	'80185039' => '0839',
	'80185040' => '0840',
	'80185041' => '0841',
	'80185042' => '0842',
	'80185043' => '0843',
	'80185044' => '0844',
	'80185045' => '0845',
	'80185046' => '0846',
	'80185047' => '0847',
	'80185048' => '0848',
	'80185049' => '0849',
	'80185050' => '0850',
	'8519001' => '0851',
	'8519002' => '0852',
	'8519003' => '0853',
	'8519004' => '0854',
	'8519005' => '0855',
	'8519006' => '0856',
	'8519007' => '0857',
	'8519008' => '0858',
	'8519009' => '0859',
	'85190010' => '0860',
	'85190011' => '0861',
	'85190012' => '0862',
	'85190013' => '0863',
	'85190014' => '0864',
	'85190015' => '0865',
	'85190016' => '0866',
	'85190017' => '0867',
	'85190018' => '0868',
	'85190019' => '0869',
	'85190020' => '0870',
	'85190021' => '0871',
	'85190022' => '0872',
	'85190023' => '0873',
	'85190024' => '0874',
	'85190025' => '0875',
	'85190026' => '0876',
	'85190027' => '0877',
	'85190028' => '0878',
	'85190029' => '0879',
	'85190030' => '0880',
	'85190031' => '0881',
	'85190032' => '0882',
	'85190033' => '0883',
	'85190034' => '0884',
	'85190035' => '0885',
	'85190036' => '0886',
	'85190037' => '0887',
	'85190038' => '0888',
	'85190039' => '0889',
	'85190040' => '0890',
	'85190041' => '0891',
	'85190042' => '0892',
	'85190043' => '0893',
	'85190044' => '0894',
	'85190045' => '0895',
	'85190046' => '0896',
	'85190047' => '0897',
	'85190048' => '0898',
	'85190049' => '0899',
	'85190050' => '0900',
	'9019501' => '0901',
	'9019502' => '0902',
	'9019503' => '0903',
	'9019504' => '0904',
	'9019505' => '0905',
	'9019506' => '0906',
	'9019507' => '0907',
	'9019508' => '0908',
	'9019509' => '0909',
	'90195010' => '0910',
	'90195011' => '0911',
	'90195012' => '0912',
	'90195013' => '0913',
	'90195014' => '0914',
	'90195015' => '0915',
	'90195016' => '0916',
	'90195017' => '0917',
	'90195018' => '0918',
	'90195019' => '0919',
	'90195020' => '0920',
	'90195021' => '0921',
	'90195022' => '0922',
	'90195023' => '0923',
	'90195024' => '0924',
	'90195025' => '0925',
	'90195026' => '0926',
	'90195027' => '0927',
	'90195028' => '0928',
	'90195029' => '0929',
	'90195030' => '0930',
	'90195031' => '0931',
	'90195032' => '0932',
	'90195033' => '0933',
	'90195034' => '0934',
	'90195035' => '0935',
	'90195036' => '0936',
	'90195037' => '0937',
	'90195038' => '0938',
	'90195039' => '0939',
	'90195040' => '0940',
	'90195041' => '0941',
	'90195042' => '0942',
	'90195043' => '0943',
	'90195044' => '0944',
	'90195045' => '0945',
	'90195046' => '0946',
	'90195047' => '0947',
	'90195048' => '0948',
	'90195049' => '0949',
	'90195050' => '0950',
	'95110001' => '0951',
	'95110002' => '0952',
	'95110003' => '0953',
	'95110004' => '0954',
	'95110005' => '0955',
	'95110006' => '0956',
	'95110007' => '0957',
	'95110008' => '0958',
	'95110009' => '0959',
	'951100010' => '0960',
	'951100011' => '0961',
	'951100012' => '0962',
	'951100013' => '0963',
	'951100014' => '0964',
	'951100015' => '0965',
	'951100016' => '0966',
	'951100017' => '0967',
	'951100018' => '0968',
	'951100019' => '0969',
	'951100020' => '0970',
	'951100021' => '0971',
	'951100022' => '0972',
	'951100023' => '0973',
	'951100024' => '0974',
	'951100025' => '0975',
	'951100026' => '0976',
	'951100027' => '0977',
	'951100028' => '0978',
	'951100029' => '0979',
	'951100030' => '0980',
	'951100031' => '0981',
	'951100032' => '0982',
	'951100033' => '0983',
	'951100034' => '0984',
	'951100035' => '0985',
	'951100036' => '0986',
	'951100037' => '0987',
	'951100038' => '0988',
	'951100039' => '0989',
	'951100040' => '0990',
	'951100041' => '0991',
	'951100042' => '0992',
	'951100043' => '0993',
	'951100044' => '0994',
	'951100045' => '0995',
	'951100046' => '0996',
	'951100047' => '0997',
	'951100048' => '0998',
	'951100049' => '0999',
	'951100050' => '1000',
	'100110501' => '1001',
	'100110502' => '1002',
	'100110503' => '1003',
	'100110504' => '1004',
	'100110505' => '1005',
	'100110506' => '1006',
	'100110507' => '1007',
	'100110508' => '1008',
	'100110509' => '1009',
	'1001105010' => '1010',
	'1001105011' => '1011',
	'1001105012' => '1012',
	'1001105013' => '1013',
	'1001105014' => '1014',
	'1001105015' => '1015',
	'1001105016' => '1016',
	'1001105017' => '1017',
	'1001105018' => '1018',
	'1001105019' => '1019',
	'1001105020' => '1020',
	'1001105021' => '1021',
	'1001105022' => '1022',
	'1001105023' => '1023',
	'1001105024' => '1024',
	'1001105025' => '1025',
	'1001105026' => '1026',
	'1001105027' => '1027',
	'1001105028' => '1028',
	'1001105029' => '1029',
	'1001105030' => '1030',
	'1001105031' => '1031',
	'1001105032' => '1032',
	'1001105033' => '1033',
	'1001105034' => '1034',
	'1001105035' => '1035',
	'1001105036' => '1036',
	'1001105037' => '1037',
	'1001105038' => '1038',
	'1001105039' => '1039',
	'1001105040' => '1040',
	'1001105041' => '1041',
	'1001105042' => '1042',
	'1001105043' => '1043',
	'1001105044' => '1044',
	'1001105045' => '1045',
	'1001105046' => '1046',
	'1001105047' => '1047',
	'1001105048' => '1048',
	'1001105049' => '1049',
	'1001105050' => '1050',
	'105111001' => '1051',
	'105111002' => '1052',
	'105111003' => '1053',
	'105111004' => '1054',
	'105111005' => '1055',
	'105111006' => '1056',
	'105111007' => '1057',
	'105111008' => '1058',
	'105111009' => '1059',
	'1051110010' => '1060',
	'1051110011' => '1061',
	'1051110012' => '1062',
	'1051110013' => '1063',
	'1051110014' => '1064',
	'1051110015' => '1065',
	'1051110016' => '1066',
	'1051110017' => '1067',
	'1051110018' => '1068',
	'1051110019' => '1069',
	'1051110020' => '1070',
	'1051110021' => '1071',
	'1051110022' => '1072',
	'1051110023' => '1073',
	'1051110024' => '1074',
	'1051110025' => '1075',
	'1051110026' => '1076',
	'1051110027' => '1077',
	'1051110028' => '1078',
	'1051110029' => '1079',
	'1051110030' => '1080',
	'1051110031' => '1081',
	'1051110032' => '1082',
	'1051110033' => '1083',
	'1051110034' => '1084',
	'1051110035' => '1085',
	'1051110036' => '1086',
	'1051110037' => '1087',
	'1051110038' => '1088',
	'1051110039' => '1089',
	'1051110040' => '1090',
	'1051110041' => '1091',
	'1051110042' => '1092',
	'1051110043' => '1093',
	'1051110044' => '1094',
	'1051110045' => '1095',
	'1051110046' => '1096',
	'1051110047' => '1097',
	'1051110048' => '1098',
	'1051110049' => '1099',
	'1051110050' => '1100',
	'110111501' => '1101',
	'110111502' => '1102',
	'110111503' => '1103',
	'110111504' => '1104',
	'110111505' => '1105',
	'110111506' => '1106',
	'110111507' => '1107',
	'110111508' => '1108',
	'110111509' => '1109',
	'1101115010' => '1110',
	'1101115011' => '1111',
	'1101115012' => '1112',
	'1101115013' => '1113',
	'1101115014' => '1114',
	'1101115015' => '1115',
	'1101115016' => '1116',
	'1101115017' => '1117',
	'1101115018' => '1118',
	'1101115019' => '1119',
	'1101115020' => '1120',
	'1101115021' => '1121',
	'1101115022' => '1122',
	'1101115023' => '1123',
	'1101115024' => '1124',
	'1101115025' => '1125',
	'1101115026' => '1126',
	'1101115027' => '1127',
	'1101115028' => '1128',
	'1101115029' => '1129',
	'1101115030' => '1130',
	'1101115031' => '1131',
	'1101115032' => '1132',
	'1101115033' => '1133',
	'1101115034' => '1134',
	'1101115035' => '1135',
	'1101115036' => '1136',
	'1101115037' => '1137',
	'1101115038' => '1138',
	'1101115039' => '1139',
	'1101115040' => '1140',
	'1101115041' => '1141',
	'1101115042' => '1142',
	'1101115043' => '1143',
	'1101115044' => '1144',
	'1101115045' => '1145',
	'1101115046' => '1146',
	'1101115047' => '1147',
	'1101115048' => '1148',
	'1101115049' => '1149',
	'1101115050' => '1150',
	'115112001' => '1151',
	'115112002' => '1152',
	'115112003' => '1153',
	'115112004' => '1154',
	'115112005' => '1155',
	'115112006' => '1156',
	'115112007' => '1157',
	'115112008' => '1158',
	'115112009' => '1159',
	'1151120010' => '1160',
	'1151120011' => '1161',
	'1151120012' => '1162',
	'1151120013' => '1163',
	'1151120014' => '1164',
	'1151120015' => '1165',
	'1151120016' => '1166',
	'1151120017' => '1167',
	'1151120018' => '1168',
	'1151120019' => '1169',
	'1151120020' => '1170',
	'1151120021' => '1171',
	'1151120022' => '1172',
	'1151120023' => '1173',
	'1151120024' => '1174',
	'1151120025' => '1175',
	'1151120026' => '1176',
	'1151120027' => '1177',
	'1151120028' => '1178',
	'1151120029' => '1179',
	'1151120030' => '1180',
	'1151120031' => '1181',
	'1151120032' => '1182',
	'1151120033' => '1183',
	'1151120034' => '1184',
	'1151120035' => '1185',
	'1151120036' => '1186',
	'1151120037' => '1187',
	'1151120038' => '1188',
	'1151120039' => '1189',
	'1151120040' => '1190',
	'1151120041' => '1191',
	'1151120042' => '1192',
	'1151120043' => '1193',
	'1151120044' => '1194',
	'1151120045' => '1195',
	'1151120046' => '1196',
	'1151120047' => '1197',
	'1151120048' => '1198',
	'1151120049' => '1199',
	'1151120050' => '1200',
	'120112501' => '1201',
	'120112502' => '1202',
	'120112503' => '1203',
	'120112504' => '1204',
	'120112505' => '1205',
	'120112506' => '1206',
	'120112507' => '1207',
	'120112508' => '1208',
	'120112509' => '1209',
	'1201125010' => '1210',
	'1201125011' => '1211',
	'1201125012' => '1212',
	'1201125013' => '1213',
	'1201125014' => '1214',
	'1201125015' => '1215',
	'1201125016' => '1216',
	'1201125017' => '1217',
	'1201125018' => '1218',
	'1201125019' => '1219',
	'1201125020' => '1220',
	'1201125021' => '1221',
	'1201125022' => '1222',
	'1201125023' => '1223',
	'1201125024' => '1224',
	'1201125025' => '1225',
	'1201125026' => '1226',
	'1201125027' => '1227',
	'1201125028' => '1228',
	'1201125029' => '1229',
	'1201125030' => '1230',
	'1201125031' => '1231',
	'1201125032' => '1232',
	'1201125033' => '1233',
	'1201125034' => '1234',
	'1201125035' => '1235',
	'1201125036' => '1236',
	'1201125037' => '1237',
	'1201125038' => '1238',
	'1201125039' => '1239',
	'1201125040' => '1240',
	'1201125041' => '1241',
	'1201125042' => '1242',
	'1201125043' => '1243',
	'1201125044' => '1244',
	'1201125045' => '1245',
	'1201125046' => '1246',
	'1201125047' => '1247',
	'1201125048' => '1248',
	'1201125049' => '1249',
	'1201125050' => '1250',
	'125113001' => '1251',
	'125113002' => '1252',
	'125113003' => '1253',
	'125113004' => '1254',
	'125113005' => '1255',
	'125113006' => '1256',
	'125113007' => '1257',
	'125113008' => '1258',
	'125113009' => '1259',
	'1251130010' => '1260',
	'1251130011' => '1261',
	'1251130012' => '1262',
	'1251130013' => '1263',
	'1251130014' => '1264',
	'1251130015' => '1265',
	'1251130016' => '1266',
	'1251130017' => '1267',
	'1251130018' => '1268',
	'1251130019' => '1269',
	'1251130020' => '1270',
	'1251130021' => '1271',
	'1251130022' => '1272',
	'1251130023' => '1273',
	'1251130024' => '1274',
	'1251130025' => '1275',
	'1251130026' => '1276',
	'1251130027' => '1277',
	'1251130028' => '1278',
	'1251130029' => '1279',
	'1251130030' => '1280',
	'1251130031' => '1281',
	'1251130032' => '1282',
	'1251130033' => '1283',
	'1251130034' => '1284',
	'1251130035' => '1285',
	'1251130036' => '1286',
	'1251130037' => '1287',
	'1251130038' => '1288',
	'1251130039' => '1289',
	'1251130040' => '1290',
	'1251130041' => '1291',
	'1251130042' => '1292',
	'1251130043' => '1293',
	'1251130044' => '1294',
	'1251130045' => '1295',
	'1251130046' => '1296',
	'1251130047' => '1297',
	'1251130048' => '1298',
	'1251130049' => '1299',
	'1251130050' => '1300',
	'130113501' => '1301',
	'130113502' => '1302',
	'130113503' => '1303',
	'130113504' => '1304',
	'130113505' => '1305',
	'130113506' => '1306',
	'130113507' => '1307',
	'130113508' => '1308',
	'130113509' => '1309',
	'1301135010' => '1310',
	'1301135011' => '1311',
	'1301135012' => '1312',
	'1301135013' => '1313',
	'1301135014' => '1314',
	'1301135015' => '1315',
	'1301135016' => '1316',
	'1301135017' => '1317',
	'1301135018' => '1318',
	'1301135019' => '1319',
	'1301135020' => '1320',
	'1301135021' => '1321',
	'1301135022' => '1322',
	'1301135023' => '1323',
	'1301135024' => '1324',
	'1301135025' => '1325',
	'1301135026' => '1326',
	'1301135027' => '1327',
	'1301135028' => '1328',
	'1301135029' => '1329',
	'1301135030' => '1330',
	'1301135031' => '1331',
	'1301135032' => '1332',
	'1301135033' => '1333',
	'1301135034' => '1334',
	'1301135035' => '1335',
	'1301135036' => '1336',
	'1301135037' => '1337',
	'1301135038' => '1338',
	'1301135039' => '1339',
	'1301135040' => '1340',
	'1301135041' => '1341',
	'1301135042' => '1342',
	'1301135043' => '1343',
	'1301135044' => '1344',
	'1301135045' => '1345',
	'1301135046' => '1346',
	'1301135047' => '1347',
	'1301135048' => '1348',
	'1301135049' => '1349',
	'1301135050' => '1350',
	'135114001' => '1351',
	'135114002' => '1352',
	'135114003' => '1353',
	'135114004' => '1354',
	'135114005' => '1355',
	'135114006' => '1356',
	'135114007' => '1357',
	'135114008' => '1358',
	'135114009' => '1359',
	'1351140010' => '1360',
	'1351140011' => '1361',
	'1351140012' => '1362',
	'1351140013' => '1363',
	'1351140014' => '1364',
	'1351140015' => '1365',
	'1351140016' => '1366',
	'1351140017' => '1367',
	'1351140018' => '1368',
	'1351140019' => '1369',
	'1351140020' => '1370',
	'1351140021' => '1371',
	'1351140022' => '1372',
	'1351140023' => '1373',
	'1351140024' => '1374',
	'1351140025' => '1375',
	'1351140026' => '1376',
	'1351140027' => '1377',
	'1351140028' => '1378',
	'1351140029' => '1379',
	'1351140030' => '1380',
	'1351140031' => '1381',
	'1351140032' => '1382',
	'1351140033' => '1383',
	'1351140034' => '1384',
	'1351140035' => '1385',
	'1351140036' => '1386',
	'1351140037' => '1387',
	'1351140038' => '1388',
	'1351140039' => '1389',
	'1351140040' => '1390',
	'1351140041' => '1391',
	'1351140042' => '1392',
	'1351140043' => '1393',
	'1351140044' => '1394',
	'1351140045' => '1395',
	'1351140046' => '1396',
	'1351140047' => '1397',
	'1351140048' => '1398',
	'1351140049' => '1399',
	'1351140050' => '1400',
	'140114501' => '1401',
	'140114502' => '1402',
	'140114503' => '1403',
	'140114504' => '1404',
	'140114505' => '1405',
	'140114506' => '1406',
	'140114507' => '1407',
	'140114508' => '1408',
	'140114509' => '1409',
	'1401145010' => '1410',
	'1401145011' => '1411',
	'1401145012' => '1412',
	'1401145013' => '1413',
	'1401145014' => '1414',
	'1401145015' => '1415',
	'1401145016' => '1416',
	'1401145017' => '1417',
	'1401145018' => '1418',
	'1401145019' => '1419',
	'1401145020' => '1420',
	'1401145021' => '1421',
	'1401145022' => '1422',
	'1401145023' => '1423',
	'1401145024' => '1424',
	'1401145025' => '1425',
	'1401145026' => '1426',
	'1401145027' => '1427',
	'1401145028' => '1428',
	'1401145029' => '1429',
	'1401145030' => '1430',
	'1401145031' => '1431',
	'1401145032' => '1432',
	'1401145033' => '1433',
	'1401145034' => '1434',
	'1401145035' => '1435',
	'1401145036' => '1436',
	'1401145037' => '1437',
	'1401145038' => '1438',
	'1401145039' => '1439',
	'1401145040' => '1440',
	'1401145041' => '1441',
	'1401145042' => '1442',
	'1401145043' => '1443',
	'1401145044' => '1444',
	'1401145045' => '1445',
	'1401145046' => '1446',
	'1401145047' => '1447',
	'1401145048' => '1448',
	'1401145049' => '1449',
	'1401145050' => '1450',
	);

#Strip out any alphabetical character from each PDF filename, remove trailing period, and rename the file according to the %deobfuscated hash

#The thing to do here is add a logical branch.  If the filename exists in the deobfuscated hash, do rename/push as original.  If not, prepend 99 to name and push.

#This works.  However, the else block is tricky in that it probably is going to handle single and double numbers incorrectly.  It will probably sort 1,10,2,20,3.  So, to fix that, I'm going to have to write something to deal with the irregular files in a more programmatic way.  How can that be done?

foreach my $file (@PDFs) {
	$_ = $file;
	s/[a-zA-Z]//g;
	chop $_;
	my $NewName = $_;
	if (exists $deobfuscated{$NewName}) {	#if the resulting name appears in the deobfuscated hash, push the keyed value into an array of filenames to be used
		rename $file, $deobfuscated{$NewName};
		push @numbered, $deobfuscated{$NewName};
	}
	else {	#if not, prepend a 99 to sort the resulting files to the end of the array (this should catch irregular names (ex, if 67 docs are created, 1-50 will be in the hash, and 51-67 will not be, but this will still sort them to the end.
#		rename $file, "99$NewName";
#		push @numbered, "99$NewName";
	rename $file, $NewName;
	push @irregular, $NewName;
	}
}

#Process irregular names

@irregular = sort @irregular;

#Take the first thing off @irregular and set that as the length to compare irregular items to.  Rename it to sort first after the deobfuscated names and send it to @numbered.
my $FirstShort = shift @irregular;
my $length = length($FirstShort);
rename $FirstShort, "99000$FirstShort";
push @numbered, "99000$FirstShort";
say "$FirstShort pushed to numbered";
#push @irregular, $FirstShort;
say "length is $length";

foreach my $file (@irregular) {
#If the filename is short, send it to the short array
	if (length($file) == $length) {
		push @short, $file;
		say "$file pushed to short";
	}	
#If the filename is not short, rename it to sort at the end of the numbered array
	else {
		rename $file, "99$file";
		push @numbered, "99$file";
		say "$file pushed to numbered";
	}
}

@short = sort @short;

#For all the other short filenames, rename them to sort before the long irregulars, but after firstshort
foreach my $file (@short){
	state $i = '1';
	rename $file, "9900$i";
	push @numbered, "9900$i";
	$i++;
	say "$file renamed to 9900$i";
}

@numbered = sort @numbered; #put files in correct order

print "sorted numbered is @numbered\n";

#Read filenames.txt into program (should be sorted in same order that PDFs were created, formatted as one filename per line)
open "inputfilehandle",'<:encoding(UTF-8)',"$inputfile" or die "cannot open input file $inputfile: $!";
while ( defined ( $_ = <inputfilehandle> )) {
	chomp $_;
	push @filenames, $_;	
}

# rename the files according to that @filenames array
while (@numbered) {
	my $file = pop @numbered;
	my $rename = pop @filenames;
	rename $file, "$rename.pdf";
#	say "$file renamed to $rename.pdf";
}