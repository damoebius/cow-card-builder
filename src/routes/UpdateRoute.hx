package routes;

import model.ModelLocator;
import core.Config;
import express.Request;
import express.Response;
import express.Router;
import js.node.ChildProcess;

class UpdateRoute extends BaseRoute {

    private static inline var PATH:String = "/update";

    public function new() {
        super();
    }

    override public function init(router:Router):Void {

        router.get(PATH, function(req:Request, res:Response):Void {

            ChildProcess.execSync("wget -O " + Config.FILENAME + " " + Config.getInstance().cards);
            ModelLocator.getInstance().update();
            middleware.Cache.instance.reset();
            res.send("cards.xlsx downloaded");

        });

    }

}
