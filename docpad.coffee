cheerio = require('cheerio')
url = require('url')

categories = {
	'여행': ['준비'],
	'대한민국': ['서울','인천','부산','경기도','강원도','충청남도','충청북도','전라남도','전라북도','경상남도','경상북도','제주도'],
	# '대한민국': ['서울','인천','대전','대구','울산','광주','부산','경기도','강원도','충청남도','충청북도','전라남도','전라북도','경상남도','경상북도','제주도'],
	'유럽': ['이탈리아','스페인','프랑스','독일','영국','아일랜드','노르웨이','스웨덴','오스트리아','헝가리','슬로바키아'],
	'아시아': ['중국','일본','태국','라오스','베트남','말레이시아','필리핀'],
	'중동': ['터키','시리아','요르단'],
	'아프리카': ['이집트'],
	'북미': ['미국','캐나다'],
	'남미': [],
	'오세아니아': [],
	'책': ['수필','소설','희곡','시','철학','건강비결','사회','창작기술','자기계발','기술','기타_책'],
	'지식': ['언어','인문학','기타_지식'],
	'건강': ['식사','운동','명상','기타_건강'],
	'영화': ['한국영화','영국영화','미국영화','프랑스영화','이탈리아영화','스웨덴영화','독일영화','루마니아영화','홍콩영화','인도영화'],
	'드라마': ['국내','국외'],
	'음악': ['재즈','록','힙합','팝','어쿠스틱','트랜스','기타_음악'],
	'문화': ['연극','뮤지컬','음악회','춤','전시','콘퍼런스'],
	'조리법': ['요리','활동식','음료'],
	'사용기': ['전자제품', '음향', '기타_사용기'],
	'동물': ['고양이'],
	'IT': ['web','db','sccm','testing','blog', 'OS','3D','development','mobile','환경','이론','tip','app','etc'],
	'취미': ['사진', '자전거','무술','수영','다이빙', '음주가무'],
	'월풍': ['독백','일기','사유','창작','삶']
}

# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {
     
	#envirnments:
	#	static:
	#		plugins:
	#			cleanurls:
	#				static: true
	#				trailingSlashes: false
	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		# Specify some site properties
		site:
			# The production url of our website
			url: "http://dorajistyle.net"

			# Here are some old site urls that you would like to redirect from
			oldUrls: [
				'http://dorajistyle.net'				
			]

			# The default title of our website
			title: "월풍도원(月風道院) STATIC Version - Delight on the Simple Life"

			# The website description (for SEO)
			description: """
				방랑자의 이야기 STATIC 버전.(STATIC version of stories about vagabond.)
				"""

			# The website keywords (for SEO) separated by commas
			keywords: """
				여행,명상,철학,방랑,행복,인생,IT,vagabond,travel,trip,meditation,philosophy,happiness,life
				"""

			# The website author's name
			author: "JOONGSEOB VITO KIM"

			# The website author's email
			email: "dorajissanai@nate.com"

			# Styles
			styles: [
				"http://yui.yahooapis.com/pure/0.3.0/pure-min.css"
				"http://code.ionicframework.com/ionicons/1.5.2/css/ionicons.min.css"
				"/styles/style.css"
			]

			# Scripts
			scripts: [				
				"/scripts/main.js"
			]		



		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		getPageUrlWithHostname: ->
			"#{@site.url}#{@document.url}"

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(', ')

		getIdForDocument: (document) ->
			hostname = url.parse(@site.url).hostname
			date = document.date.toISOString().split('T')[0]
			path = document.url
			"tag:#{hostname},#{date},#{path}"

		fixLinks: (content) ->
			baseUrl = @site.url
			regex = /^(http|https|ftp|mailto):/

			$ = cheerio.load(content)
			$('img').each ->
				$img = $(@)
				src = $img.attr('src')
				$img.attr('src', baseUrl + src) unless regex.test(src)
			$('a').each ->
				$a = $(@)
				href = $a.attr('href')
				$a.attr('href', baseUrl + href) unless regex.test(href)
			$.html()

		getTagUrl: (tag) ->
			slug = tag.toLowerCase().replace(/[^a-z0-9]/g, '-').replace(/-+/g, '-').replace(/^-|-$/g, '')
			"/tags/#{slug}/"

		# Disus.com settings
		disqusShortName: 'dorajistyle-static'

		# Google+ settings
		googlePlusId: '111183731766919710839'


	# =================================
	# Collections
	# These are special collections that our website makes available to us

	collections:
		# pages: (database) ->
		# 	database.findAllLive({pageTest: $exists: true}, [pageTest:1,title:1])				
		# posts: (database) ->
		# 	database.findAllLive({tags:$has:'post'}, [date:-1])

		'여행': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '여행'}, [title:1])
		'준비': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['여행','준비'].join('/')
				}, [{date: -1}]
			)

		'대한민국': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '대한민국'}, [title:1])
		'서울': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','서울'].join('/')
				}, [{date: -1}]
			)
		'인천': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','인천'].join('/')
				}, [{date: -1}]
			)
		'대전': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','대전'].join('/')
				}, [{date: -1}]
			)
		'대구': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','대구'].join('/')
				}, [{date: -1}]
			)			
		'울산': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','울산'].join('/')
				}, [{date: -1}]
			)			
		'광주': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','광주'].join('/')
				}, [{date: -1}]
			)			
		'부산': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','부산'].join('/')
				}, [{date: -1}]
			)			
		'경기도': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','경기도'].join('/')
				}, [{date: -1}]
			)			
		'강원도': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','강원도'].join('/')
				}, [{date: -1}]
			)			
		'충청남도': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','충청남도'].join('/')
				}, [{date: -1}]
			)			
		'충청북도': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','충청북도'].join('/')
				}, [{date: -1}]
			)			
		'전라남도': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','전라남도'].join('/')
				}, [{date: -1}]
			)			
		'전라북도': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','전라북도'].join('/')
				}, [{date: -1}]
			)			
		'경상남도': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','경상남도'].join('/')
				}, [{date: -1}]
			)			
		'경상북도': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','경상북도'].join('/')
				}, [{date: -1}]
			)			
		'제주도': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['대한민국','제주도'].join('/')
				}, [{date: -1}]
			)			

		'유럽': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '유럽'}, [title:1])
		'이탈리아': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','이탈리아'].join('/')
				}, [{date: -1}]
			)			
		'스페인': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','스페인'].join('/')
				}, [{date: -1}]
			)						
		'프랑스': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','프랑스'].join('/')
				}, [{date: -1}]
			)						
		'독일': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','독일'].join('/')
				}, [{date: -1}]
			)						
		'영국': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','영국'].join('/')
				}, [{date: -1}]
			)						
		'아일랜드': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','아일랜드'].join('/')
				}, [{date: -1}]
			)						
		'노르웨이': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','노르웨이'].join('/')
				}, [{date: -1}]
			)						
		'스웨덴': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','스웨덴'].join('/')
				}, [{date: -1}]
			)						
		'오스트리아': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','오스트리아'].join('/')
				}, [{date: -1}]
			)						
		'헝가리': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','헝가리'].join('/')
				}, [{date: -1}]
			)						
		'슬로바키아': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['유럽','슬로바키아'].join('/')
				}, [{date: -1}]
			)						

		'아시아': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '아시아'}, [title:1])
		'중국': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['아시아','중국'].join('/')
				}, [{date: -1}]
			)
		'일본': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['아시아','일본'].join('/')
				}, [{date: -1}]
			)
		'태국': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['아시아','태국'].join('/')
				}, [{date: -1}]
			)
		'라오스': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['아시아','라오스'].join('/')
				}, [{date: -1}]
			)
		'베트남': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['아시아','베트남'].join('/')
				}, [{date: -1}]
			)
		'말레이시아': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['아시아','말레이시아'].join('/')
				}, [{date: -1}]
			)
		'필리핀': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['아시아','필리핀'].join('/')
				}, [{date: -1}]
			)

		'중동': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '중동'}, [title:1])
		'터키': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['중동','터키'].join('/')
				}, [{date: -1}]
			)
		'시리아': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['중동','시리아'].join('/')
				}, [{date: -1}]
			)
		'요르단': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['중동','요르단'].join('/')
				}, [{date: -1}]
			)

		'아프리카': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '아프리카'}, [title:1])
		'이집트': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['아프리카','이집트'].join('/')
				}, [{date: -1}]
			)

		'북미': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '북미'}, [title:1])
		'미국': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['북미','미국'].join('/')
				}, [{date: -1}]
			)
		'캐나다': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['북미','캐나다'].join('/')
				}, [{date: -1}]
			)
		
		'남미': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '남미'}, [title:1])
		
		'오세아니아': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '오세아니아'}, [title:1])
		
		'책': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '책'}, [title:1])
		'수필': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','수필'].join('/')
				}, [{date: -1}]
			)
		'소설': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','소설'].join('/')
				}, [{date: -1}]
			)
		'희곡': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','희곡'].join('/')
				}, [{date: -1}]
			)
		'시': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','시'].join('/')
				}, [{date: -1}]
			)
		'철학': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','철학'].join('/')
				}, [{date: -1}]
			)
		'건강비결': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','건강비결'].join('/')
				}, [{date: -1}]
			)
		'사회': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','사회'].join('/')
				}, [{date: -1}]
			)
		'창작기술': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','창작기술'].join('/')
				}, [{date: -1}]
			)
		'자기계발': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','자기계발'].join('/')
				}, [{date: -1}]
			)
		'기술': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','기술'].join('/')
				}, [{date: -1}]
			)
		'기타_책': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['책','기타_책'].join('/')
				}, [{date: -1}]
			)

		'지식': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '지식'}, [title:1])
		'언어': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['지식','언어'].join('/')
				}, [{date: -1}]
			)
		'인문학': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['지식','인문학'].join('/')
				}, [{date: -1}]
			)
		'기타_지식': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['지식','기타_지식'].join('/')
				}, [{date: -1}]
			)

		'건강': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '건강'}, [title:1])
		'식사': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['건강','식사'].join('/')
				}, [{date: -1}]
			)
		'운동': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['건강','운동'].join('/')
				}, [{date: -1}]
			)
		'명상': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['건강','상상'].join('/')
				}, [{date: -1}]
			)
		'기타_건강': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['건강','기타_건강'].join('/')
				}, [{date: -1}]
			)

		'영화': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '영화'}, [title:1])
		'한국영화': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['영화','한국영화'].join('/')
				}, [{date: -1}]
			)
		'영국영화': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['영화','영국영화'].join('/')
				}, [{date: -1}]
			)
		'미국영화': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['영화','미국영화'].join('/')
				}, [{date: -1}]
			)
		'프랑스영화': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['영화','프랑스영화'].join('/')
				}, [{date: -1}]
			)
		'이탈리아영화': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['영화','이탈리아영화'].join('/')
				}, [{date: -1}]
			)
		'스웨덴영화': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['영화','스웨덴영화'].join('/')
				}, [{date: -1}]
			)
		'독일영화': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['영화','독일영화'].join('/')
				}, [{date: -1}]
			)
		'루마니아영화': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['영화','루마니아영화'].join('/')
				}, [{date: -1}]
			)
		'홍콩영화': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['영화','홍콩영화'].join('/')
				}, [{date: -1}]
			)
		'인도영화': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['영화','인도영화'].join('/')
				}, [{date: -1}]
			)

		'드라마': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '드라마'}, [title:1])
		'국내': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['드라마','국내'].join('/')
				}, [{date: -1}]
			)
		'국외': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['드라마','국외'].join('/')
				}, [{date: -1}]
			)

		'음악': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '음악'}, [title:1])
		'재즈': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['음악','재즈'].join('/')
				}, [{date: -1}]
			)
		'록': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['음악','록'].join('/')
				}, [{date: -1}]
			)
		'힙합': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['음악','힙합'].join('/')
				}, [{date: -1}]
			)
		'팝': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['음악','팝'].join('/')
				}, [{date: -1}]
			)
		'어쿠스틱': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['음악','어쿠스틱'].join('/')
				}, [{date: -1}]
			)
		'트랜스': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['음악','트랜스'].join('/')
				}, [{date: -1}]
			)
		'기타_음악': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['음악','기타_음악'].join('/')
				}, [{date: -1}]
			)

		'문화': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '문화'}, [title:1])
		'연극': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['문화','연극'].join('/')
				}, [{date: -1}]
			)
		'뮤지컬': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['문화','뮤지컬'].join('/')
				}, [{date: -1}]
			)
		'음악회': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['문화','음악회'].join('/')
				}, [{date: -1}]
			)
		'춤': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['문화','춤'].join('/')
				}, [{date: -1}]
			)		
		'전시': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['문화','전시'].join('/')
				}, [{date: -1}]
			)
		'콘퍼런스': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['문화','콘퍼런스'].join('/')
				}, [{date: -1}]
			)				

		'조리법': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '조리법'}, [title:1])
		'요리': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['조리법','요리'].join('/')
				}, [{date: -1}]
			)
		'활동식': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['조리법','활동식'].join('/')
				}, [{date: -1}]
			)
		'음료': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['조리법','음료'].join('/')
				}, [{date: -1}]
			)

		'사용기': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '사용기'}, [title:1])
		'전자제품': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['사용기','전자제품'].join('/')
				}, [{date: -1}]
			)
		'음향': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['사용기','음향'].join('/')
				}, [{date: -1}]
			)
		'기타_사용기': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['사용기','기타_사용기'].join('/')
				}, [{date: -1}]
			)

		'동물': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '동물'}, [title:1])
		'고양이': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['동물','고양이'].join('/')
				}, [{date: -1}]
			)

		'IT': ->
			@getCollection('html').findAllLive({relativeOutDirPath: 'IT'}, [title:1])
		'web': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','web'].join('/')
				}, [{date: -1}]
			)
		'db': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','db'].join('/')
				}, [{date: -1}]
			)
		'sccm': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','sccm'].join('/')
				}, [{date: -1}]
			)
		'testing': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','testing'].join('/')
				}, [{date: -1}]
			)
		'blog': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','blog'].join('/')
				}, [{date: -1}]
			)		
		'OS': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','OS'].join('/')
				}, [{date: -1}]
			)		
		'3D': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','3D'].join('/')
				}, [{date: -1}]
			)
		'development': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','development'].join('/')
				}, [{date: -1}]
			)
		'mobile': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','mobile'].join('/')
				}, [{date: -1}]
			)		
		'환경': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','환경'].join('/')
				}, [{date: -1}]
			)
		'이론': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','이론'].join('/')
				}, [{date: -1}]
			)
		'tip': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','tip'].join('/')
				}, [{date: -1}]
			)
		'app': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','app'].join('/')
				}, [{date: -1}]
			)
		'etc': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['IT','etc'].join('/')
				}, [{date: -1}]
			)

		'취미': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '취미'}, [title:1])
		'사진': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['취미','사진'].join('/')
				}, [{date: -1}]
			)
		'자전거': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['취미','자전거'].join('/')
				}, [{date: -1}]
			)
		'무술': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['취미','무술'].join('/')
				}, [{date: -1}]
			)
		'수영': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['취미','수영'].join('/')
				}, [{date: -1}]
			)
		'다이빙': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['취미','다이빙'].join('/')
				}, [{date: -1}]
			)
		'음주가무': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['취미','음주가무'].join('/')
				}, [{date: -1}]
			)		

		'월풍': ->
			@getCollection('html').findAllLive({relativeOutDirPath: '월풍'}, [title:1])
		'독백': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['월풍','독백'].join('/')
				}, [{date: -1}]
			)
		'일기': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['월풍','일기'].join('/')
				}, [{date: -1}]
			)
		'사유': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['월풍','사유'].join('/')
				}, [{date: -1}]
			)
		'창작': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['월풍','창작'].join('/')
				}, [{date: -1}]
			)
		'삶': ->
			@getCollection('html').findAllLive({
				relativeOutDirPath: ['월풍','삶'].join('/')
				}, [{date: -1}]
			)

        # Configure Plugins
        # Should contain the plugin short names on the left, and the configuration to pass the plugin on the right
	#watchOptions:
	#	interval: 2007
#		preferredMethods: ['watchFile','watch']
	watchOptions: null
	
	plugins:
		moment:
			formats: [
				{raw: 'date', format: 'MMMM Do YYYY', formatted: 'humanDate'}
				{raw: 'date', format: 'YYYY-MM-DD', formatted: 'computerDate'}
			]
		ghpages:
     		deployRemote: 'target'
     		deployBranch: 'master'
		# tags:
		# 	findCollectionName: '대한민국'
		# 	extension: '.html'
		# 	injectDocumentHelper: (document) ->
		# 		document.setMeta(
		# 			layout: 'tags'
		# 		)
		#livereload:
         #   enabled: false
         
	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()
}

# Candidate of collections generator 
# for main of categories
#   docpadConfig.collections[main] = ->
#     @getCollection("html").findAllLive
#       relativeOutDirPath: main
#     , [title: 1]

#   for sub of categories[main]
#     docpadConfig.collections[categories[main][sub]] = ->
#       @getCollection("html").findAllLive
#         relativeOutDirPath: [
#           main
#           categories[main][sub]
#         ].join("/")
#         isPagedAuto:
#           $ne: true
#       , [date: -1]

  # for sub of categories[main]
  #   docpadConfig.collections[categories[main][sub]] = ->
  #   	@getCollection('html').findAllLive({
  #   		relativeOutDirPath: [main,categories[main][sub]].join('/')
  #   		}, [{date: -1}]
  #   	)




# Export our DocPad Configuration
module.exports = docpadConfig
