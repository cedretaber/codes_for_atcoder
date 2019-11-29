import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

int[][40*100+40] NS;
bool[40*100+40] BS;
bool[40*100+40] AS;

void main()
{
    auto rc = readln.split.to!(int[]);
    auto r = rc[0];
    auto c = rc[1];

    wchar[][] map;
    map.length = r;
    foreach (i; 0..r)
        map[i] = readln.chomp.to!(wchar[]);
    
    foreach (int y, row; map) {
        foreach (int x, p; row) {
            auto i = x*100 + y;
            if (x > 0 && map[y][x-1] == '.') NS[i] ~= (x-1)*100 + y;
            if (x < c-1 && map[y][x+1] == '.') NS[i] ~= (x+1)*100 + y;
            if (y > 0 && map[y-1][x] == '.') NS[i] ~= x*100 + y-1;
            if (y < r-1 && map[y+1][x] == '.') NS[i] ~= x*100 + y+1;
        }
    }

    Tuple!(int, int) solve(int i) {
        if (BS[i]) return tuple(0, 0);
        int cnt, put;
        auto can = true;
        BS[i] = true;
        foreach (n; NS[i]) {
            if (!BS[n]) {
                auto ret = solve(n);
                cnt += ret[0];
                put += ret[1];
            }
            if (AS[n]) can = false;
        }
        if (can) {
            AS[i] = true;
            ++put;
        }
        ++cnt;
        return tuple(cnt, put);
    }

    int cnt;
    foreach (y; 0..r) {
        foreach (x; 0..c) {
            if (map[y][x] == '*') continue;
            auto ret = solve(x*100 + y);
            cnt += max(ret[0] - ret[1], ret[1]);
        }
    }
    writeln(cnt);
}