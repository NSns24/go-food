Food.delete_all

Food.create!(
	name: "Tenderloin Steak",
	description: 
		%{<p>
			Tenderloin hanya terdapat di bagian tengah sapi.
      	</p>},
    image_url: "Tenderloin.png",
    price: 95000.00
)

Food.create!(
	name: "Sirloin Steak",
	description: 
		%{<p>
			<em>Best Seller</em>
			Sirloin adalah daging bagian atas dari sapi yang ada jalur lemaknya di sisi atas.
      	</p>},
    image_url: "Sirloin.png",
    price: 85000.00
)

Food.create!(
	name: "Rib Eye Steak",
	description: 
		%{<p>
			<em>Paling Populer dan Paling Juicy</em>
			Rib Eye adalah bagian daging sapi yang berasal dari daging di sekitar tulang iga.
      	</p>},
    image_url: "Rib Eye.png",
    price: 90000.00
)