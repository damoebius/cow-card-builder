package ;

import js.Node;
import middleware.Cache;
import middleware.Logger;
import model.ModelLocator;
import mw.BodyParser;
import node.express.ExpressServer;
import node.mustache.Mustache;
import routes.ApiRouter;

class CardBuilder {

    private static var _instance:CardBuilder;

    private var _express:ExpressServer;

    public function new() {
        Logger.info("Card Builder Server");
        startServer();

    }

    private function startServer():Void{
        Logger.info("startServer on http://localhost:4444");
        var mustache = new Mustache();
        _express = new ExpressServer();
        _express.use(BodyParser.json());
        _express.use("/api", cast ApiRouter.getRouter());
        _express.use("/", ExpressServer.serveStatic(Node.__dirname + '/www'));
        _express.listen(4444);
        _express.engine('mustache', mustache);
        _express.set('view engine', 'mustache');
        _express.set('views', Node.__dirname + '/www/views');
        Cache.setCache(mustache.cache);
        ModelLocator.getInstance().update();
    }


    public static function main(){
        _instance = new CardBuilder();
    }
}
