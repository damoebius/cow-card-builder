package routes;

import express.Request;
import express.Response;
import express.Router;

class CardRoute extends BaseRoute {

    private static inline var PATH:String = "/";

    public function new() {
        super();
    }

    override public function init(router:Router):Void {

        router.get(PATH, function(req:Request, res:Response):Void {
            res.render('card', { logs: "" });
        });

    }
}
