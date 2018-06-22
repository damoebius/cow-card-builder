package ;

import node.Puppeteer;
import node.XLSX;
import js.node.Fs;
import js.node.http.IncomingMessage;
import js.node.Https;
import core.Config;
import js.Node;

class CardBuilder {

    private static inline var FILENAME:String="cards.xlsx";

    private static var _instance:CardBuilder;

    public function new() {
        Node.console.info("Card Builder");
        var arg = Node.process.argv[2];
        switch (arg){
            case "load":
                loadData();
            case "build":
                buildData();
            default :
                Node.console.error("missing option : load|build");
        }


    }

    private function loadData():Void{
        var file = Fs.createWriteStream(FILENAME);
        Https.get(Config.getInstance().cards,function(message:IncomingMessage){
            file.on('finish', function() {
                Node.console.info("cards.xlsx downloaded");
            });
        });
    }

    private function buildData():Void{
        var fileBuffer = Fs.readFileSync(FILENAME);
        var workbook = XLSX.read(fileBuffer,{type:"buffer"});
        Puppeteer.launch().then(
            function(browser:node.Browser){
                Node.console.info("browser launched");
                browser.newPage().then(
                    function(page:node.Page){
                        page.addListener("load", function(){
                            Node.console.info("page loaded");
                        });
                        page.goto("http://localhost:4444/card.html");
                    }
                );
            }
        );
        Node.console.info(workbook.SheetNames[0]);
    }

    public static function main(){
        _instance = new CardBuilder();
    }
}
