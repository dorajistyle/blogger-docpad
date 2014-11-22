module.exports = function (grunt) {
    'use strict';

var layout_prefix = "---\\nlayout: default\\n---\\n\\n",
    layout_postfix = "\\n\\n<%- @partial('main', {document: @document, content: @content}) %>";

var categories = {
	'여행': ['준비'],
	'대한민국': ['서울','인천','부산','경기도','강원도','충청남도','충청북도','전라남도','전라북도','경상남도','경상북도','제주도'],
	//'대한민국': ['서울','인천','대전','대구','울산','광주','부산','경기도','강원도','충청남도','충청북도','전라남도','전라북도','경상남도','경상북도','제주도'],
	'유럽': ['이탈리아','스페인','프랑스','독일','영국','아일랜드','노르웨이','스웨덴','오스트리아','헝가리','슬로바키아'],
	'아시아': ['중국','일본','태국','라오스','베트남','말레이시아','필리핀'],
	'중동': ['터키','시리아','요르단'],
	'아프리카': ['이집트'],
	'북미': ['미국','캐나다'],
	'남미': [],
	'오세아니아': [],
	'책': ['수필','소설','희곡','시','철학','명상','건강비결','사회','창작기술','자기계발','기술','기타_책'],
	'지식': ['언어','사회','인문학','기타_지식'],
	'건강': ['식사','운동','명상','기타_건강'],
	'영화': ['한국','영국','미국','프랑스','이탈리아','스웨덴','독일','루마니아','홍콩','인도'],
	'드라마': ['국내','국외'],
	'음악': ['재즈','록','힙합','팝','어쿠스틱','트랜스','기타_음악'],
	'문화': ['연극','뮤지컬','음악회','춤','전시','콘퍼런스'],
	'조리법': ['요리','활동식','음료'],
	'사용기': ['전자제품', '음향', '기타_사용기'],
	'동물': ['고양이'],
	'IT': ['web','db','sccm','testing','blog', 'OS','3D','development','mobile','환경','이론','tip','app','etc'],
	'취미': ['사진', '자전거','무술','수영','다이빙', '음주가무'],
	'월풍': ['독백','일기','사유','창작','삶']  
        };

var intros = {'여행': "이곳은 **여행 전반**에 걸친 이야기가 적힌 곳입니다.",
              '대한민국': "이곳은 **대한민국** 여행기가 적힌 곳입니다.",
              '유럽': "이곳은 **유럽** 여행기가 적힌 곳입니다.",
              '아시아': "이곳은 **아시아** 여행기가 적힌 곳입니다.",
              '중동': "이곳은 **중동** 여행기가 적힌 곳입니다.",
              '아프리카': "이곳은 **아프리카** 여행기가 적힌 곳입니다.",
              '북미': "이곳은 **북미** 여행기가 적힌 곳입니다.",
              '남미': "이곳은 **남미** 여행기가 적힌 곳입니다.",
              '오세아니아': "이곳은 **오세아니아** 여행기가 적힌 곳입니다.",
              '책': "이곳은 **책** 이야기가 적힌 곳입니다.",
              '지식': "이곳은 **지식** 이야기가 적힌 곳입니다.",
              '건강': "이곳은 **건강** 이야기가 적힌 곳입니다.",
              '영화': "이곳은 **영화** 이야기가 적힌 곳입니다.",
              '드라마': "이곳은 **드라마** 이야기가 적힌 곳입니다.",
              '음악': "이곳은 **음악** 이야기가 적힌 곳입니다.",
              '문화': "이곳은 **문화** 이야기가 적힌 곳입니다.",
              '조리법': "이곳은 **조리법** 이야기가 적힌 곳입니다.",
              '사용기': "이곳은 **사용기**가 적힌 곳입니다.",
              '동물': "이곳은 **동물** 이야기가 적힌 곳입니다.",
              'IT':"이곳은 **IT** 이야기가 적힌 곳입니다." ,
              '취미': "이곳은 **취미** 이야기가 적힌 곳입니다.",
              '월풍': "이곳은 **월풍** 이야기가 적힌 곳입니다." 
              };


var titles = {'여행': "여행 전반",
              '대한민국': "대한민국 여행기",
              '유럽': "유럽 여행기",
              '아시아': "아시아 여행기",
              '중동': "중동 여행기",
              '아프리카': "아프리카 여행기",
              '북미': "북미 여행기",
              '남미': "남미 여행기",
              '오세아니아': "오세아니아 여행기",
              '책': "책 감상평",
              '지식': "지식 이야기",
              '건강': "건강 이야기",
              '영화': "영화 감상평",
              '드라마': "드라마 감상평",
              '음악': "음악 감상실",
              '문화': "문화생활",
              '조리법': "조리법",
              '사용기': "제품 사용기",
              '동물': "동물 이야기",
              'IT': "IT 이야기" ,
              '취미': "취미생활",
              '월풍': "월풍담" 
              };


var descriptions = {'여행': "",
              '대한민국': "한국 팔도를 여행하며 겪은 순간순간의 기억",
              '유럽': "유럽을 돌아다니며 겪은 순간순간의 기억",
              '아시아': "아시아를 떠돌며 겪은 순간순간의 기억",
              '중동': "중동을 여행하며 겪은 기억의 단편",
              '아프리카': "아프리카를 돌아다니며 겪은 기억",
              '북미': "북미를 여행하며 겪은 기억",
              '남미': "남미를 여행하며 겪은 기억",
              '오세아니아': "오세아니아를 여행하며 겪은 기억",
              '책': "책을 읽고 느낀점",
              '지식': "보고들은 지식",
              '건강': "건강한 삶을 사는 방법",
              '영화': "영화를 보고 느낀점",
              '드라마': "드라마를 보고 느낀점",
              '음악': "기억하고 싶은 음악",
              '문화': "",
              '조리법': "맛있는 음식을 만드는 법",
              '사용기': "",
              '동물': "",
              'IT': "소프트웨어 개발과 IT전반에 걸친 이야기." ,
              '취미': "취미생활",
              '월풍': "월풍은 어떤 생각을 하고 사나?" 
              };



    grunt.file.defaultEncoding = 'utf8';
    var updated_at = grunt.file.read('updated_at.txt', {encoding: "UTF-8"});
    // Project configuration.
    require('time-grunt')(grunt);
    grunt.initConfig({
    pkg: grunt.file.readJSON('./package.json'),
    shell: {
      echo_date: {
        command: function () {
           return 'echo "'+updated_at+'"'; 
        }
        
      },
      generate_templates: {
        command: function () {
            var str='';
            
            for(var category in categories){
                //str+='echo main '+category+' && ';
                var sub_length = categories[category].length;
                if(sub_length > 0) {
                
                str+= 'if [ -d "documents/'+category+'" ]; then echo -e "---\\ntitle: '+category
                   +'\\nlayout: '+category
                   +'\\ntags: [\'intro\',\'page\']\\n---\\n\\n'
                   +intros[category]
                   +'" > documents/'+category+'/index.html.md; fi && ';

               str+='if [ -d "layouts" ]; then echo -e "'+layout_prefix
                  +'<%- @partial(\'nav\', {title: \''+titles[category]
                  +'\', description: \''+descriptions[category]
                  +'\', collection: \''+category+'\'}) %>'+layout_postfix
                  +'" > layouts/'+category+'.html.eco; fi && ';
               
              for(var j=0;j<categories[category].length;j++) {
                str+='if [ -d "documents/'+category+'" ]; then echo -e "---\\ntitle: '+categories[category][j]
                +'\\nlayout: '+category
                +'\\n---\\n\\n'
                +'<%- @partial(\'list\', {collectionName: \''+categories[category][j]+'\'}) %>\\n'
                //+'<%- @partial(\'pagination\', {document: @document }) %>'
                +'" > documents/'+category+'/'+categories[category][j]+'.html.eco; fi && ';

            }
                }
            }
            console.log(str);
            return str+'echo "finish"';

        },
        options: {
          stdout: true
        }
      },
      import_blogger:{
        command: function () {
            var str='';
            for(var category in categories){
                //str+='echo main '+category+' && ';
              for(var j=0;j<categories[category].length;j++) {
                
                  //str+='echo ss'+categories[category][j]+' && ';
                  
                  str+='ruby -rubygems -e \'require "jekyll-import";JekyllImport::Importers::BLOGGER_DOCPAD.run({"source" => "http://www.dorajistyle.pe.kr/feeds/posts/default/-/'+encodeURIComponent(category)+'/'+encodeURIComponent(categories[category][j])+'?max-results=105&orderby=published&alt=rss&published-max=2999-12-31T23:59:59&published-min='+updated_at+'","layout" => "'+category+'","dest" => "documents/'+category+'/'+categories[category][j]+'"})\' && ';



              }
            }
//            str='ruby -rubygems -e \'require "jekyll-import";    JekyllImport::Importers::RSS.run({"source" => "http://www.dorajistyle.pe.kr/feeds/posts/default/-/%EC%B1%85/%EC%86%8C%EC%84%A4?max-results=105&orderby=published&alt=rss","dest" => "인천/즁규"})\'';
            console.log(str);
            return str+'echo "finish" && sed "$d" updated_at.txt >> updated_at.history && echo "$(date +%Y-%m-%d)T00:00:00" > updated_at.txt';
            //return str;
        },
        options: {
            stdout: true
        }
      }
    },

  });

  grunt.registerTask('date', ['shell:echo_date']);
  grunt.registerTask('import', ['shell:import_blogger']);
  grunt.registerTask('generate', ['shell:generate_templates']);



  grunt.loadNpmTasks('grunt-shell');
};
