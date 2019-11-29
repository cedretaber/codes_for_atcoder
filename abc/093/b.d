import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto abk = readln.split.to!(int[]);
    auto A = abk[0];
    auto B = abk[1];
    auto K = abk[2];

    int[] res;
    for (auto i = A; i < A + K && i <= B; ++i) {
        res ~= i;
    }
    for (auto i = B; i > B - K && i >= A; --i) {
        res ~= i;
    }
    sort(res);
    foreach (i; uniq(res)) writeln(i);
}