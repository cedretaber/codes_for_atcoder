import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias S = Tuple!(int, "d", int, "h", int, "w");

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    auto cc = readln.split.to!(int[]);
    auto ch = cc[0]-1;
    auto cw = cc[1]-1;
    auto dd = readln.split.to!(int[]);
    auto dh = dd[0]-1;
    auto dw = dd[1]-1;

    char[][] MAP;
    foreach (_; 0..H) MAP ~= readln.chomp.to!(char[]);

    auto memo = new int[][](H, W);
    foreach (ref dp; memo) dp[] = int.max/3;
    memo[ch][cw] = 0;
    auto ss = heapify!"a.d > b.d"([S(0, ch, cw)]);
    while (!ss.empty) {
        auto t = ss.front;
        ss.removeFront();
        static foreach (d; [[0,1], [1,0], [-1,0], [0,-1]]) {{
            auto h = t.h + d[0];
            auto w = t.w + d[1];
            if (h >= 0 && h < H && w >= 0 && w < W && MAP[h][w] == '.' && memo[h][w] > t.d) {
                memo[h][w] = t.d;
                ss.insert(S(t.d, h, w));
            }
        }}
        static foreach (ph; -2..3) {{
            static foreach (pw; -2..3) {{
                auto h = t.h + ph;
                auto w = t.w + pw;
                if (h >= 0 && h < H && w >= 0 && w < W && MAP[h][w] == '.' && memo[h][w] > t.d+1) {
                    memo[h][w] = t.d+1;
                    ss.insert(S(t.d+1, h, w));
                }
            }}
        }}
    }
    writeln(memo[dh][dw] == int.max/3 ? -1 : memo[dh][dw]);
}