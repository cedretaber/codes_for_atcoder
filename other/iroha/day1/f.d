import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    if (K > 30) {
        writeln("-1");
        return;
    }

    int i = 2;
    int[] r;
    while (N != 1 && i <= N && r.length < K-1) {
        if (N % i == 0) {
            r ~= i;
            N /= i;
        } else {
            ++i;
        }
    }
    if (r.length == K-1 && N != 1) {
        writeln((r ~ N).to!(string[]).join(" "));
    } else {
        writeln("-1");
    }
}