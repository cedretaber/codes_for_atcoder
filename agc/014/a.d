import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abc = readln.split.to!(long[]);
    auto A = abc[0];
    auto B = abc[1];
    auto C = abc[2];

    int r;
    foreach (_; 0..1000) {
        if (A%2 == 1 || B%2 == 1 || C%2 == 1) {
            writeln(r);
            return;
        }
        ++r;
        auto a = (B+C)/2;
        auto b = (A+C)/2;
        auto c = (A+B)/2;
        A = a;
        B = b;
        C = c;
    }
    writeln(-1);
}