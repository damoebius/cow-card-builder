package routes;

import express.Router;

class ApiRouter {

    public static function getRouter():Router {
        var router = new Router();
        new CardRoute().init(router);
        new LangRoute().init(router);
        new UpdateRoute().init(router);
        new RenderRoute().init(router);
        return router;
    }
}
