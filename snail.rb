def snail(array)
  perim = (0..array.length-1)
  out = []
  array.each_with_index do |row, ri|
    row.each_with_index do |cell, ci|
      out << cell
      until out.count == array.count
        #i call x y and y x, just so i can write the code how i want to
        [[0,1],[-1,0],[0,-1],[1,0]].each do |y, x|
          while (ri + y).between?(0,array.count-1) && (ri + y).between?(0,array.count-1) && !out.include?(array[ri+y][ci+x])
            sr = ri + y
            sc = ci + x
            break if out.include?array[sr][sc] || !sr.between?(0,array.count-1) || !sc.between?(0,array.count-1)
            out << array[sr][sc]
            ri = sr
            ci = sc
          end
        end
      end
    end
  end
  out
end

p snail([[1,2,3],
        [4,5,6],
        [7,8,9]])