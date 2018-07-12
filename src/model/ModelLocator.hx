package model;

import middleware.Logger;
import js.Node;
import node.XLSX.Workbook;

class ModelLocator {

    private static var _instance:ModelLocator;

    public var langs(default, null):Array<Lang>;

    private function new() {
        langs = [];
    }

    public function fromWorkbook(workbook:Workbook):Void {
        langs = [];
        for (i in 0...workbook.SheetNames.length) {
            var lang = new Lang(workbook.SheetNames[i]);
            this.langs.push(lang);

            var sheet = workbook.Sheets[lang.name];
            var fields = Reflect.fields(sheet);
            for (field in fields) {
                var letter:String = field.charAt(0);
                var index:Int = Std.parseInt(field.substring(1));
                if (lang.cards[index] == null) {
                    lang.cards[index] = new Card();
                }
                var card = lang.cards[index];
                card.langId = i;
                switch(letter){
                    case 'A':
                        card.name = Reflect.field(sheet, field).h;
                    case 'B':
                        card.cost = Reflect.field(sheet, field).h;
                        card.costHtml = getHtmlText(card.cost);
                    case 'C':
                        card.type = Reflect.field(sheet, field).h;
                        card.tags = card.type != null ? card.type.split(" ") : [];
                    case 'D':
                        card.att = Reflect.field(sheet, field).v;
                    case 'E':
                        card.def = Reflect.field(sheet, field).v;
                    case 'F':
                        card.description = Reflect.field(sheet, field).h ;
                        if (card.description != null) {
                            card.description = StringTools.htmlUnescape(card.description).split("&apos;").join("'");
                            card.description = getHtmlText(card.description);
                        }

                    default :
                        //Logger.error("unknown letter " + letter);
                }
            }
            lang.cards = lang.cards.filter(function(n){ return n != null; });
            lang.cards.shift();
            for(i in 0...lang.cards.length){
                lang.cards[i].id = i;
            }
            lang.id = i;
        }
    }

    public function getHtmlText(text:String):String{
        var result ="";
        if (text != null) {
            result = text;
            result = StringTools.replace(result,'[b]','<img class="cost" src="/images/php-icon.png">');
            result = StringTools.replace(result,'[r]','<img class="cost" src="/images/java-icon.png">');
            result = StringTools.replace(result,'[g]','<img class="cost" src="/images/cpp-icon.png">');
            result = StringTools.replace(result,'[j]','<img class="cost" src="/images/javascript-icon.png">');
            result = StringTools.replace(result,'[b]','<img class="cost" src="/images/php-icon.png">');
            result = new EReg("\\[(.)]", "i").replace(result,'<span class="cost-anon">$1</span>');
        }
        return result;
    }

    public static function getInstance():ModelLocator {
        if (_instance == null) {
            _instance = new ModelLocator();
        }
        return _instance;
    }
}
