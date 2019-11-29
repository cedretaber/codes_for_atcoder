import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abc = readln.split.to!(double[]);
    auto A = abc[0];
    auto B = abc[1];
    auto C = abc[2];

    double f(double t) {
        return A * t + B * sin(C * t * PI);
    }

    if (abs(f(0) - 100) < 1.0e-06) {
        writeln(0);
        return;
    }

    double min_t = 0, max_t = 2;
    while (f(max_t) < 100) max_t *= 2;
    foreach (_; 0..1000) {
        auto mid_t = (min_t + max_t) / 2;
        if (f(mid_t) < 100) {
            min_t = mid_t;
        } else {
            max_t = mid_t;
        }
    }
    writefln("%0.20f", max_t);
}