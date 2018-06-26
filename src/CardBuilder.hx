package ;

import model.ModelLocator;
import routes.ApiRouter;
import middleware.Logger;
import middleware.Cache;
import mw.BodyParser;
import node.mustache.Mustache;
import node.express.ExpressServer;
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

    private var _express:ExpressServer;

    public function new() {
        Logger.info("Card Builder");
        Node.console.dir(Node.process.argv);
        if(Node.process.argv.indexOf("load") >= 0){
            loadData();
        } else if(Node.process.argv.indexOf("build") >= 0){
            buildCards();
        } else if(Node.process.argv.indexOf("start") >= 0){
            startServer();
        } else {
            Logger.error("missing option : load|build|start");
        }

    }

    private function startServer():Void{
        Logger.info("startServer on http://localhost:4444");
        var mustache = new Mustache();
        _express = new ExpressServer();
        _express.use(BodyParser.json());
        _express.use("/langs", cast ApiRouter.getRouter());
        _express.use("/", ExpressServer.serveStatic(Node.__dirname + '/www'));
        _express.listen(4444);
        _express.engine('mustache', mustache);
        _express.set('view engine', 'mustache');
        _express.set('views', Node.__dirname + '/www/views');
        Cache.setCache(mustache.cache);
        buildData();
    }

    private function loadData():Void{
        var file = Fs.createWriteStream(FILENAME);
        Https.get(Config.getInstance().cards,function(message:IncomingMessage){
            file.on('finish', function() {
                Logger.info("cards.xlsx downloaded");
            });
        });
    }

    private function buildData():Void{
        var fileBuffer = Fs.readFileSync(FILENAME);
        var workbook = XLSX.read(fileBuffer,{type:"buffer"});
        ModelLocator.getInstance().fromWorkbook(workbook);
    }

    private function buildCards():Void{
        Logger.info("build cards");
    }

    public static function main(){
        _instance = new CardBuilder();
    }
}
