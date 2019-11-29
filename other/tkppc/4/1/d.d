import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    if (N == 1) {
        writeln(0);
        return;
    } else if (N == 2) {
        writeln(as[0] == as[1] ? 0 : 2);
        return;
    }

    int c = 1, first = as[0], second = as[1];
    foreach (a; as[2..$]) {
        if ((first < second && second > a) || (first > second && second < a)) {
            ++c;
            first = second;
            second = a;
        } else {
            second = a;
        }
    }
    writeln(c == 1 && as[0] == as[$-1] ? 0 : c+1);
}