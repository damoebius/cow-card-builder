package routes;

import express.Request;
import express.Response;
import express.Router;
import middleware.Cache;
import middleware.Logger;
import model.ModelLocator;

class LangRoute extends BaseRoute {

    private static inline var PATH:String = "/langs/:langId";

    public function new() {
        super();
    }

    override public function init(router:Router):Void {

        router.get(PATH, function(req:Request, res:Response):Void {
            var langId = Std.parseInt(req.param("langId"));
            Cache.instance.reset();
            try {
                res.render('lang', { lang: ModelLocator.getInstance().langs[langId] });
            } catch (error:js.Error) {
                Logger.error("error while rendering lang");
            }
        });

    }
}
