package tickertest.ticker
{
    import flash.display.Stage;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    /**
     * @author Simone Vicentini
     */
    public class TimerLoopTicker implements Ticker
    {
        private var fns:Array;

        private var count:int;

        private var timer:Timer;

        public function TimerLoopTicker(root:Stage)
        {
            timer = new Timer(1000 / root.frameRate);
            timer.addEventListener(TimerEvent.TIMER, timerEvent);
            fns = [];
            count = 0;
        }

        public function start():void
        {
            timer.start();
        }

        public function stop():void
        {
            timer.stop();
        }

        public function addListener(fn:Function):void
        {
            if (fns.indexOf(fn) == -1)
                fns[count++] = fn;
        }

        public function removeListener(fn:Function):void
        {
            var i:uint = fns.indexOf(fn);
            if (i != -1)
            {
                fns.splice(i, 1);
                --count;
            }
        }

        private function timerEvent(event:TimerEvent):void
        {
            var i:int = count;
            while (--i > -1)
            {
                var fn:Function = fns[i];
                fn();
            }
        }

    }
}
