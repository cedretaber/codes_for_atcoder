import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto ks = readln.split.to!(int[]);
    auto k = ks[0];
    auto s = ks[1];

    long cnt;
    foreach (x; 0..k+1) {
        foreach (y; x..k+1) {
            auto  z = s - x - y;
            if (z < y || z > k) continue;
            if (x == y && y == z)
                ++cnt;
            else if (x == y || y == z || z == x)
                cnt += 3;
            else
                cnt += 6;
        }
    }
    writeln(cnt);
}