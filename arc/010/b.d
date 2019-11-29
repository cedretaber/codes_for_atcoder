import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;
import std.datetime, core.time : days;

void main()
{
    auto d = Date(2012, 1, 1);
    
    auto N = readln.chomp.to!int;
    Date[] hs;
    foreach (_; 0..N) {
        auto md = readln.chomp.split("/").to!(int[]);
        hs ~= Date(2012, md[0], md[1]);
    }

    int s, max_s, r;
    while (d.year <= 2012) {
        bool is_h;
        foreach (h; hs) if (h == d) {
            is_h = true;
            break;
        }
        if (d.dayOfWeek == DayOfWeek.sat || d.dayOfWeek == DayOfWeek.sun) {
            ++s;
            if (is_h) ++r;
        } else if (is_h) {
            ++s;
        } else if (r) {
            --r;
            ++s;
        } else if (s) {
            max_s = max(max_s, s);
            s = 0;
        }
        d += 1.days;
    }
    if (s) {
        max_s = max(max_s, s);
    }
    writeln(max_s);
}