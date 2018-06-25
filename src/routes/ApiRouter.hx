package routes;

import express.Request;
import express.Response;
import express.Router;

class ApiRouter {

    public static function getRouter():Router {
        var router = new Router();
        /*router.get("/", function(req:Request, res:Response):Void {
            res.json("Cow API");
        });*/


        new CardRoute().init(router);
        return router;
    }
}
