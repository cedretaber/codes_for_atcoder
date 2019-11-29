import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    auto S = readln.chomp.to!(char[]);

    long[] NS;
    long n;
    char last;
    foreach (c; S) {
        if (c == last) {
            ++n;
        } else {
            if (n) NS ~= n;
            n = 1;
            last = c;
        }
    }
    NS ~= n;
    
    while (NS.length > 1 && K) {
        --K;
        if (NS.length == 2) {
            NS[0] += NS[1];
            NS = NS[0..1];
        } else if (NS.length == 3) {
            NS[0] += NS[1] + NS[2];
            NS = NS[0..1];
        } else {
            NS[1] += NS[0];
            NS[$-2] += NS[$-1];
            NS = NS[1..$-1];
        }
    }

    long r;
    foreach (x; NS) r += x-1;
    writeln(r);
}