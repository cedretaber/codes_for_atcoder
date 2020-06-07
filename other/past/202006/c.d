import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto arn = readln.split.to!(long[]);
    auto A = arn[0];
    auto R = arn[1];
    auto N = arn[2];
    if (R == 1) {
        writeln(A);
        return;
    }

    foreach (_; 0..N-1) {
        if (A * R < A || A * R > 10L^^9) {
            writeln("large");
            return;
        }
        A *= R;
    }
    writeln(A);
}