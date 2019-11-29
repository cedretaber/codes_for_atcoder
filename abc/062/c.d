import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    long h, w;
    readf("%d %d", &h, &w);

    if (h%3 == 0 || w%3 == 0) {
        writeln("0");
        return;
    }

    long ret_d = long.max;

    foreach (wd; 1..w) {
        auto hb = h * wd;
        auto wb1 = (h+1)/2 * (w-wd);
        auto wb2 = h/2 * (w-wd);
        auto dd1 = max(hb, wb1, wb2) - min(hb, wb1, wb2);

        auto h2 = h * ((w-wd+1)/2);
        auto h3 = h * ((w-wd)/2);
        auto dd2 = max(hb, h2, h3) - min(hb, h2, h3);

        auto dd = min(dd1, dd2);

        if (dd < ret_d) ret_d = dd;
    }

    foreach (hd; 1..h) {
        auto wb = hd * w;
        auto hb1 = (h-hd) * ((w+1)/2);
        auto hb2 = (h-hd) * (w/2);
        auto dd1 = max(wb, hb1, hb2) - min(wb, hb1, hb2);

        auto w2 = ((h-hd+1)/2) * w;
        auto w3 = ((h-hd)/2) * w;
        auto dd2 = max(wb, w2, w3) - min(wb, w2, w3);

        auto dd = min(dd1, dd2);

        if (dd < ret_d) ret_d = dd;
    }

    writeln(ret_d);
}